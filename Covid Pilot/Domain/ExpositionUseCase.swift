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
    
    private let disposeBag = DisposeBag()
    private let dateFormatter = DateFormatter()
    
    private let subject: BehaviorSubject<ExpositionInfo>
    private let expositionInfoRepository: ExpositionInfoRepository
    private let notificationHandler: NotificationHandler
    private let kpiControllerApi: KpiControllerAPI
    
    init(notificationHandler: NotificationHandler,
         expositionInfoRepository: ExpositionInfoRepository,
         kpiControllerApi: KpiControllerAPI) {
        
        self.notificationHandler = notificationHandler
        self.expositionInfoRepository = expositionInfoRepository
        self.kpiControllerApi = kpiControllerApi
        self.subject = BehaviorSubject<ExpositionInfo>(value: expositionInfoRepository.getExpositionInfo() ?? ExpositionInfo(level: .Healthy))
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss.SSS z"
        
        DP3TTracing.delegate = self
        
    }
    
    func DP3TTracingStateChanged(_ state: TracingState) {

        if var expositionInfo = tracingStatusToExpositionInfo(tStatus: state) {
            
            let localEI  = expositionInfoRepository.getExpositionInfo()
            
            if isNewInfected(localEI, expositionInfo) {
                expositionInfo.since = Date()
            }
            
            if showNotification(localEI, expositionInfo) {
                    
                kpiControllerApi.saveKpi(body: [KpiDto(
                    kpi: .matchConfirmed,
                    timestamp: dateFormatter.string(from: Date()),
                    value: 1)]).subscribe (
                onError: { error in
                        debugPrint("Erorr sending MatchConfirmed KPI \(error)")
                }, onCompleted:{
                    debugPrint("MatchConfirmed KPI sent")
                }).disposed(by: disposeBag)

                notificationHandler.scheduleNotification(expositionInfo: expositionInfo)
            }
            if (expositionInfo.error == nil ) {
                expositionInfoRepository.save(expositionInfo: expositionInfo)
            }
            
            subject.onNext(expositionInfo)
        }
    }
    
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        subject.asObservable()
    }
    
    func getExpositionInfoFromRepository() -> ExpositionInfo! {
        return expositionInfoRepository.getExpositionInfo() ?? ExpositionInfo(level: .Healthy)
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
                var errorEI = ExpositionInfo(level: expositionInfoRepository.getExpositionInfo()?.level ?? .Healthy)
                errorEI.error = dp3tTracingErrorToDomain(error)
                return errorEI
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
    
    private func showNotification(_ localEI:ExpositionInfo?,  _ expositionInfo: ExpositionInfo) -> Bool {
        if let localEI = localEI {
            return !equals(localEI, expositionInfo) && expositionInfo.level == .Exposed
        }
        return false
    }
    
    private func equals(_ ei1: ExpositionInfo, _ ei2: ExpositionInfo) -> Bool {
        ei1.level == ei2.level && ei1.since == ei2.since
    }
    
    private func isNewInfected(_ localEI:ExpositionInfo?,  _ expositionInfo: ExpositionInfo) -> Bool {
        if let localEI = localEI {
            return !equals(localEI, expositionInfo) && expositionInfo.level == .Infected
        }
        return expositionInfo.level == .Infected
        
    }
    
    private func dp3tTracingErrorToDomain(_ error: DP3TTracingError) -> DomainError? {
        switch error {
            case .bluetoothTurnedOff:
                return .BluetoothTurnedOff
            case .permissonError:
                return .NotAuthorized
            default:
                debugPrint("Error State \(error)")
                return nil
        }
    }
    

}
