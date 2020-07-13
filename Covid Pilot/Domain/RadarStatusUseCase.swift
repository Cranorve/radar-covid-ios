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
    private let syncUseCase: SyncUseCase
    
    init(preferencesRepository: PreferencesRepository,
         errorUseCase: ErrorUseCase,
         syncUseCase: SyncUseCase) {
        self.preferencesRepository = preferencesRepository
        self.errorUseCase = errorUseCase
        self.syncUseCase = syncUseCase
    }
    
    func isTracingActive() -> Bool {
        preferencesRepository.isTracingActive()
    }
    
    func changeTracingStatus(active: Bool) -> Observable<Bool> {
        .create { [weak self] observer in
            if (active){
                do {
                    try DP3TTracing.startTracing { error in
                        if let error =  error {
                            observer.onError(error)
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
    
    func restoreLastStateAndSync() -> Observable<Bool> {
        changeTracingStatus(active: preferencesRepository.isTracingActive()).flatMap { [weak self] active -> Observable<Bool> in

            if (active) {
                return self?.syncUseCase.syncIfNeeded().map { active } ?? .empty()
            }
            return .just(active)
        }
    }

    func isTracingInit() -> Bool {
        preferencesRepository.isTracingInit()
    }
    
    
    private func handle(error: Error) -> Error {
        let domainError: DomainError = DomainError.Unexpected
        if let dp3tError = error as? DP3TTracingError {
            debugPrint(dp3tError)
        }
        
        if let enError = error as? ENError {
            if enError.code == ENError.Code.notAuthorized {

            }
        }
        
        return domainError
    }


}
    

