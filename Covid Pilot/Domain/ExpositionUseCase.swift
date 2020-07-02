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
    
    private let subject = BehaviorSubject<ExpositionInfo>(value: ExpositionInfo(level: .Healthy(lastCheck: Date())))
    private let notificationHandler: NotificationHandler
    
    init(notificationHandler: NotificationHandler) {
        self.notificationHandler = notificationHandler
        DP3TTracing.delegate = self
    }
    
    func DP3TTracingStateChanged(_ state: TracingState) {
        let expositionInfo = tracingStatusToExpositionInfo(tStatus: state)
        subject.onNext(expositionInfo)
        notificationHandler.scheduleNotification(expositionInfo: expositionInfo)
    }
    
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        subject.asObservable()
    }
    
    func updateExpositionInfo() {
        
        DP3TTracing.status { result in
            switch result {
            case let .success(state):
                subject.onNext(tracingStatusToExpositionInfo(tStatus: state))
            case .failure:
                subject.onError("Error retrieving exposition status")
            }
        }

    }
    
    // Metodo para mapear un TracingState a un ExpositionInfo
    private func tracingStatusToExpositionInfo(tStatus: TracingState) -> ExpositionInfo {
        switch tStatus.infectionStatus {
        case .healthy:
            return ExpositionInfo(level: ExpositionInfo.Level.Healthy(lastCheck: tStatus.lastSync))
        case .infected:
            return ExpositionInfo(level: ExpositionInfo.Level.Infected)
        case .exposed(days: let days):
            return ExpositionInfo(level: ExpositionInfo.Level.Exposed(since: days.first?.exposedDate, lastCheck: tStatus.lastSync))
        }
    }
    
    
}
