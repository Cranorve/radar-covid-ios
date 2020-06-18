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
    
    func changeRadarStatus(active: Bool) -> Observable<Bool> {
        .create { observer in
            if (active){
                do {
                    try DP3TTracing.startTracing { error in
                        if let error =  error {
                            observer.onError("Error starting tracing. : \(error)")
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError("Error starting tracing. : \(error)")
                }
                
            } else {
                DP3TTracing.stopTracing { error in
                    if let error =  error {
                        observer.onError("Error starting tracing. : \(error)")
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
            
    }

}
    

