//
//  SetupUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 29/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import DP3TSDK

class SetupUseCase : LoggingDelegate, ActivityDelegate {
    
    private let preferencesRepository: PreferencesRepository
    
    init(preferencesRepository: PreferencesRepository) {
        self.preferencesRepository = preferencesRepository
    }
    
    func initializeSDK() {
        
        let url = URL(string: Config.endpoints.dpppt)!
//        DP3TTracing.loggingEnabled = true
        DP3TTracing.loggingDelegate = self
        DP3TTracing.activityDelegate = self
        try! DP3TTracing.initialize(with: .init(appId: "es.gob.radarcovid",
                                                bucketBaseUrl: url,
                                                reportBaseUrl: url,
                                                jwtPublicKey: Config.validationKey,
                                                mode: Config.dp3tMode) )
        
        if (preferencesRepository.isTracingActive()) {
            do {
                try DP3TTracing.startTracing()
            } catch {
                debugPrint("Error starting tracing \(error)")
            }
        } else {
            DP3TTracing.stopTracing()
        }
        
    }
    
    func log(_ string: String, type: OSLogType) {
//        debugPrint(string)
    }
    
    func syncCompleted(totalRequest: Int, errors: [DP3TTracingError]) {
        debugPrint("DP3T Sync totalRequest \(totalRequest)")
        for error in errors {
            debugPrint("DP3T Sync error \(error)")
        }
    }
    
    func fakeRequestCompleted(result: Result<Int, DP3TNetworkingError>) {
        debugPrint("DP3T Fake request completed...")
    }
    
    func outstandingKeyUploadCompleted(result: Result<Int, DP3TNetworkingError>) {
        debugPrint("DP3T OutstandingKeyUpload...")
    }

    
    
}
