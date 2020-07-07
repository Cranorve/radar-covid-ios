//
//  RadarStatusUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import DP3TSDK
import Foundation
import RxSwift
import ExposureNotification

class RadarStatusUseCase {
    
    private let preferencesRepository: PreferencesRepository
    private let errorUseCase: ErrorUseCase
    
    init(preferencesRepository: PreferencesRepository,
         errorUseCase: ErrorUseCase) {
        self.preferencesRepository = preferencesRepository
        self.errorUseCase = errorUseCase
    }
    
    func changeTracingStatus(active: Bool) -> Observable<Bool> {
        .create { [weak self] observer in
            if (active){
                do {
                    try DP3TTracing.startTracing { error in
                        guard let strongSelf = self else {
                            return
                        }
                        if let error =  error {
                            observer.onError(strongSelf.handle(error: error))
                        } else {
                            self?.preferencesRepository.setTracing(active: active)
                            observer.onNext(active)
                            observer.onCompleted()
                        }
                    }
                   
                } catch {
                    observer.onError("Error starting tracing. : \(error)")
                }
                
            } else {
                DP3TTracing.stopTracing { error in
                    if let error =  error {
                        observer.onError("Error stopping tracing. : \(error)")
                    }else{
                        self?.preferencesRepository.setTracing(active: active)
                        observer.onNext(active)
                        observer.onCompleted()
                    }
                }
                
            }
            return Disposables.create()
        }
            
    }
    
    func restoreLastState() -> Observable<Bool> {
        changeTracingStatus(active: preferencesRepository.isTracingActive())
    }
    
    private func handle(error: Error) -> Error {
        var domainError: DomainError = DomainError.Unexpected
        if let dp3tError = error as? DP3TTracingError {
            
        }
        
        if let enError = error as? ENError {
            if enError.code == ENError.Code.notAuthorized {
                domainError = DomainError.NotAuthorized
                errorUseCase.setState(error: domainError)
            }
        }
        
        return domainError
    }

}
    

