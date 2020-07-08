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
    
    private let subject = BehaviorSubject<ExpositionInfo>(value: ExpositionInfo(level: .Healthy))
    
    private let expositionInfoRepository: ExpositionInfoRepository
    private let notificationHandler: NotificationHandler
    private let errorUseCase: ErrorUseCase
    
    init(notificationHandler: NotificationHandler,
         expositionInfoRepository: ExpositionInfoRepository,
         errorUseCase: ErrorUseCase) {
        self.notificationHandler = notificationHandler
        self.expositionInfoRepository = expositionInfoRepository
        self.errorUseCase = errorUseCase
        DP3TTracing.delegate = self
    }
    
    func DP3TTracingStateChanged(_ state: TracingState) {
        if let expositionInfo = tracingStatusToExpositionInfo(tStatus: state) {
            subject.onNext(expositionInfo)
            if (showNotification(expositionInfo)) {
                notificationHandler.scheduleNotification(expositionInfo: expositionInfo)
            }
            expositionInfoRepository.save(expositionInfo: expositionInfo)
        }
    }
    
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        Observable.of(subject.asObservable(),getExpositionInfoErrors()).merge()
    }
    
    func updateExpositionInfo() {
        
        DP3TTracing.status { result in
            switch result {
            case let .success(state):
                if let ei = tracingStatusToExpositionInfo(tStatus: state) {
                    subject.onNext(ei)
                }
            case .failure:
                subject.onError("Error retrieving exposition status")
            }
        }

    }
    
    // Metodo para mapear un TracingState a un ExpositionInfo
    private func tracingStatusToExpositionInfo(tStatus: TracingState) -> ExpositionInfo? {
        
        switch tStatus.trackingState {
            case .inactive(let error):
                return dp3tTracingErrorToDomain(error)
            case .stopped:
                return nil
            default: break
        }
        
        switch tStatus.infectionStatus {
            case .healthy:
                var info = ExpositionInfo(level: ExpositionInfo.Level.Healthy)
                info.lastCheck = tStatus.lastSync
                return info
            case .infected:
                return ExpositionInfo(level: ExpositionInfo.Level.Infected)
            case .exposed(days: let days):
                var info = ExpositionInfo(level: ExpositionInfo.Level.Exposed)
                info.since = days.first?.exposedDate
                info.lastCheck = tStatus.lastSync
                return info
        }
    }
    
    private func showNotification(_ expositionInfo: ExpositionInfo) -> Bool {
        if let localEI = expositionInfoRepository.getExpositionInfo() {
            return !equals(localEI, expositionInfo)
        }
        return false
    }
    
    private func equals(_ ei1: ExpositionInfo, _ ei2: ExpositionInfo) -> Bool {
        ei1.level == ei2.level && ei1.since == ei2.since
    }
    
    private func dp3tTracingErrorToDomain(_ error: DP3TTracingError) -> ExpositionInfo? {
        var ei = ExpositionInfo(level: .Error)
        switch error {
            case .bluetoothTurnedOff:
                ei.error = .BluetoothTurnedOff
            case .permissonError:
                ei.error = .NotAuthorized
            default:
                debugPrint("Error State \(error)")
                return nil
        }
        return ei
    }
    
    private func getExpositionInfoErrors() -> Observable<ExpositionInfo> {
        errorUseCase.errors().filter{
            $0 != nil
        }.map { error in
            var ei = ExpositionInfo(level: .Error)
            ei.error = error
            return ei
        }
    }
    
    
}
