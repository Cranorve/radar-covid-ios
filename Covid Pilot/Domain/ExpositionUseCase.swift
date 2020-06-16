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
    
    func DP3TTracingStateChanged(_ state: TracingState) {
        // TODO Update our current expositionInfo 
    }
    
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        var tStatus : TracingState?
        DP3TTracing.status { result in
            switch result {
            case let .success(state):
                tStatus = state
            case .failure:
                break
            }
        }
        var exposition: ExpositionInfo = ExpositionInfo(level: ExpositionInfo.Level.LOW)
        if let _ = tStatus {
            switch tStatus!.infectionStatus {
            case .healthy:
                exposition = ExpositionInfo(level: ExpositionInfo.Level.LOW)
                
            case .infected:
                exposition = ExpositionInfo(level: ExpositionInfo.Level.HIGH)
            
            default:
                exposition = ExpositionInfo(level: ExpositionInfo.Level.LOW)
                
            }
        }
        
        return .just(exposition)
    }
    
}
