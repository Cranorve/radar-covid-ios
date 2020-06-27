//
//  SyncUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 27/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift
import DP3TSDK

class SyncUseCase {
    
    func sync() -> Observable<Void> {
        .create { observer in
            
            DP3TTracing.sync { result in
                switch result {
                case let .failure(error):
                    observer.onError(error)
                default:
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
}
