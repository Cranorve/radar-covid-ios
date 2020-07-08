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

class RadarStatusUseCase {
    
    private let preferencesRepository: PreferencesRepository
    private let syncUseCase: SyncUseCase
    
    init(preferencesRepository: PreferencesRepository,
         syncUseCase: SyncUseCase) {
        self.preferencesRepository = preferencesRepository
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
                            observer.onError("Error starting tracing. : \(error)")

                        }else{
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
                        observer.onError("Error starting tracing. : \(error)")
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
        changeTracingStatus(active: preferencesRepository.isTracingActive()).flatMap { [weak self] active in
            self?.syncUseCase.syncIfNeeded().map { active } ?? .empty()
        }
    }


}
    

