//
//  SetupUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 29/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import ExposureNotification
import DP3TSDK
import RxSwift

class SetupUseCase : LoggingDelegate, ActivityDelegate, DP3TBackgroundHandler {
    
    private let dateFormatter = DateFormatter()
    
    private let disposeBag = DisposeBag()
    
    private let preferencesRepository: PreferencesRepository
    private let notificationHandler: NotificationHandler
    private let kpiApi: KpiControllerAPI
    
    init(preferencesRepository: PreferencesRepository,
         kpiApi: KpiControllerAPI,
         notificationHandler: NotificationHandler) {
        self.preferencesRepository = preferencesRepository
        self.kpiApi  = kpiApi
        // CAMBIAR FORMATO DE HORA DE KPI
//        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss.SSS z"
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        self.notificationHandler = notificationHandler
    }
    
    func initializeSDK() throws {
        
        let url = URL(string: Config.endpoints.dpppt)!
//        DP3TTracing.loggingEnabled = true
        DP3TTracing.loggingDelegate = self
        DP3TTracing.activityDelegate = self
        
        try! DP3TTracing.initialize(with: .init(appId: "es.gob.radarcovid",
                                                bucketBaseUrl: url,
                                                reportBaseUrl: url,
                                                jwtPublicKey: Config.dp3tValidationKey,
                                                mode: Config.dp3tMode), backgroundHandler: self)
        
        
    }
    
    func log(_ string: String, type: OSLogType) {
//        debugPrint(string)
    }
    
    func syncCompleted(totalRequest: Int, errors: [DP3TTracingError]) {
        debugPrint("DP3T Sync totalRequest \(totalRequest)")
        for error in errors {
            debugPrint("DP3T Sync error \(error)")
        }
        preferencesRepository.setLastSync(date: Date())
    }
    
    func fakeRequestCompleted(result: Result<Int, DP3TNetworkingError>) {
        debugPrint("DP3T Fake request completed...")
    }
    
    func outstandingKeyUploadCompleted(result: Result<Int, DP3TNetworkingError>) {
        debugPrint("DP3T OutstandingKeyUpload...")
    }

    func exposureSummaryLoaded(summary: ENExposureDetectionSummary) {
        traceSummary(summary)

        let kpi = mapSummaryToKpi(summary)
        kpiApi.saveKpi(body: kpi).subscribe(
            onError: { error in
                debugPrint("Error up loading ENExposureDetectionSummary: \(error)")
            }, onCompleted: {
                debugPrint("ENExposureDetectionSummary Uploaded")
        }).disposed(by: disposeBag)
        
    }
    
    private func mapSummaryToKpi(_ summary: ENExposureDetectionSummary) -> [KpiDto] {
        var kpiDtos: [KpiDto] = []
        let date = dateFormatter.string(from: Date())
        if summary.attenuationDurations.count >= 3 {
            kpiDtos.append(KpiDto(
                kpi: .attenuationDurations1, timestamp: date,
                value: summary.attenuationDurations[0] as? Int
            ))
            kpiDtos.append(KpiDto(
                kpi: .attenuationDurations2, timestamp: date,
                value: summary.attenuationDurations[1] as? Int
            ))
            kpiDtos.append(KpiDto(
                kpi: .attenuationDurations3, timestamp: date,
                value: summary.attenuationDurations[2] as? Int
            ))
        }
        
        kpiDtos.append(KpiDto(
            kpi: .daysSinceLastExposure, timestamp: date,
            value: summary.daysSinceLastExposure
        ))
        
        kpiDtos.append(KpiDto(
            kpi: .matchedKeyCount, timestamp: date,
            value: Int(exactly: summary.matchedKeyCount)
        ))
        
        kpiDtos.append(KpiDto(
            kpi: .maximumRiskScore, timestamp: date,
            value: Int(exactly: summary.maximumRiskScore)
        ))

        kpiDtos.append(KpiDto(
            kpi: .summationRiskScore,
            timestamp: date,
            value: summary.metadata?["riskScoreSumFullRange"] as? Int
        ))
        
        return kpiDtos

    }
    
    private func traceSummary(_ summary: ENExposureDetectionSummary ) {
        debugPrint("ENExposureDetectionSummary received")
        debugPrint("- daysSinceLastExposure: \(summary.daysSinceLastExposure)")
        debugPrint("- matchedKeyCount: \(summary.matchedKeyCount)")
        debugPrint("- maximumRiskScore: \(summary.maximumRiskScore)")
        debugPrint("- riskScoreSumFullRange: \(String(describing: summary.metadata?["riskScoreSumFullRange"]))")
    }
    
    func performBackgroundTasks(completionHandler: @escaping (Bool) -> Void) {
        debugPrint("performBackgroundTasks")
        let sync = preferencesRepository.getLastSync()?.description ?? "no Sync"
        if Config.debug {
            notificationHandler.scheduleNotification(title: "BackgroundTask", body: "Last sync: \(sync)", sound: .default)
        }
    }
    
    func didScheduleBackgrounTask() {
        debugPrint("didScheduleBackgrounTask")
    }
    
    private func mapInitializeError(_ error: Error) -> DomainError {
        if let e = error as? DP3TTracingError {
            debugPrint("Error \(e)")
        }
        
        return DomainError.Unexpected
    }

}
