//
//  SyncUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 27/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift
import ExposureNotification
import DP3TSDK

class SyncUseCase {
    
    // Force sync if last sync was older than 12 hours
    private let syncInterval: TimeInterval = 10
    
    private let preferencesRepository: PreferencesRepository
    
    init(preferencesRepository: PreferencesRepository) {
        self.preferencesRepository = preferencesRepository
    }
    
    func syncIfNeeded() -> Observable<Void> {
        .deferred { [weak self] in
            if let lastSync = self?.preferencesRepository.getLastSync(), let syncInterval = self?.syncInterval {
                if (-lastSync.timeIntervalSinceNow) > syncInterval {
                    return self?.forceSync() ?? .empty()
                } else {
                    return .empty()
                }
            }
            return self?.forceSync() ?? .empty()
        }
    }
    
    func forceSync() -> Observable<Void> {
        .create { observer in
            
            DP3TTracing.sync(runningInBackground: false) { result in
                switch result {
                case let .failure(error):
                    debugPrint("Sync Error: \(error)")
                    var showError = true
                    switch error {
                    case let .networkingError(error: wrappedError):
                        
                        switch wrappedError {
                        case let .networkSessionError(netErr as NSError) where netErr.code == -999 && netErr.domain == NSURLErrorDomain:
                            debugPrint("Network Error")
                        case let .HTTPFailureResponse(status: status) where (502 ... 504).contains(status):
                            debugPrint("Network Error 500")
                        case .networkSessionError:
                            debugPrint("Network Error Session")
                        case .timeInconsistency:
                            debugPrint("Time Inconsistency ")
                        default:
                            debugPrint("Unexpected")
                        }
                    case let .exposureNotificationError(error: expError as ENError) where expError.code == ENError.Code.rateLimited:
                        // never show the ratelimit error to the user
                        // reset all error variables since it could be that we transitioned from another error state to this
                        debugPrint("RateLimited")
                        showError = false
                    case .cancelled:
                        // background task got cancelled, dont show error immediately
                        debugPrint("Cancelled")
                    default:
                        debugPrint("Unexpected")
                    }
                    if (showError) {
                        observer.onError(error)
                    } else {
                        observer.onCompleted()
                    }
                    
                default:
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
}
