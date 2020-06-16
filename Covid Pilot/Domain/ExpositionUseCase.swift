//
//  ExpositionUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import DP3TSDK
import Foundation
import RxSwift

class ExpositionUseCase: DP3TTracingDelegate {
    
    private let subject = PublishSubject<ExpositionInfo>()
    
    init() {
        DP3TTracing.delegate = self
    }
    
    func DP3TTracingStateChanged(_ state: TracingState) {
        subject.onNext(tracingStatusToExpositionInfo(tStatus: state))
    }
    
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        .deferred { [weak self] in
            DP3TTracing.status { result in
                switch result {
                case let .success(state):
                    self?.subject.onNext(self?.tracingStatusToExpositionInfo(tStatus: state) ?? ExpositionInfo(level: .LOW))
                case .failure:
                    self?.subject.onError("Algo paso mal con la peticion del status.")
                    break
                }
            }
            return self?.subject.asObservable() ?? .empty()
        }
    }
    
    // Metodo para mapear un TracingState a un ExpositionInfo
    private func tracingStatusToExpositionInfo(tStatus: TracingState) -> ExpositionInfo {
        switch tStatus.infectionStatus {
        case .healthy:
            return ExpositionInfo(level: ExpositionInfo.Level.LOW)
            
        case .infected:
            return ExpositionInfo(level: ExpositionInfo.Level.HIGH)
            
        default:
            return ExpositionInfo(level: ExpositionInfo.Level.LOW)
            
        }
    }
    
}
