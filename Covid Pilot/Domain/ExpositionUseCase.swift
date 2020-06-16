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
    
    
    
    init() {
        DP3TTracing.delegate = self
    }
    
    func DP3TTracingStateChanged(_ state: TracingState) {
        // TODO Update our current expositionInfo
            //observer.onNext(tracingStatusToExpositionInfo(tStatus: state))
    }
    
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        .create { [weak self] observer in
            DP3TTracing.status { result in
                switch result {
                case let .success(state):
                    observer.onNext(self?.tracingStatusToExpositionInfo(tStatus: state) ?? ExpositionInfo(level: .LOW))
                case .failure:
                    observer.onError("Algo paso mal con la peticion del status.")
                    break
                }
            }
            
            return Disposables.create()
            
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
