//
//  ConfiguratioUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 16/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift
import DP3TSDK

class ConfigurationUseCase {
    
    private let settingsRepository: SettingsRepository
    private let tokenApi: TokenAPI
    private let settingsApi: SettingsAPI
    private let versionHandler: VersionHandler
    
    init(settingsRepository: SettingsRepository,
         tokenApi: TokenAPI,
         settingsApi: SettingsAPI,
         versionHandler: VersionHandler) {
        self.settingsRepository = settingsRepository
        self.tokenApi = tokenApi
        self.settingsApi = settingsApi
        self.versionHandler = versionHandler
    }
    
    func loadConfig() -> Observable<Settings> {

        Observable<Settings>.zip(getUuid(),
                                 settingsApi.getSettings() ) { [weak self] token, backSettings in
                let settings = Settings()
                settings.udid = token
                settings.parameters = backSettings
                self?.loadParameters(settings)
                self?.settingsRepository.save(settings: settings)
                if let currentVersion  = self?.versionHandler.getCurrenVersion(), let minVersion = settings.parameters?.applicationVersion?.ios?.compilation {
                    settings.isUpdated = currentVersion >= minVersion
                }
                return settings
        }
    
    }

    
    private func getUuid() -> Observable<String?> {
        .deferred {
            if let settings = self.settingsRepository.getSettings() {
                return .just(settings.udid)
            }
            return self.tokenApi.getUuid().map { udid in udid.uuid }
        }
    }
    
    
    private func loadParameters(_ settings: Settings) {
        var params = DP3TTracing.parameters
        if let lower = settings.parameters?.attenuationDurationThresholds?.low {
            params.contactMatching.lowerThreshold = lower
        }
        if let higher = settings.parameters?.attenuationDurationThresholds?.medium {
            params.contactMatching.higherThreshold = higher
        }
        if let minDurationForExposure = settings.parameters?.minDurationForExposure {
            params.contactMatching.triggerThreshold = Int(minDurationForExposure)
        }
        
        if let factorLow = settings.parameters?.attenuationFactor?.low {
            params.contactMatching.factorLow = factorLow
        }
        if let factorHigh = settings.parameters?.attenuationFactor?.medium {
            params.contactMatching.factorHigh = factorHigh
        }
        DP3TTracing.parameters = params
    }
    
}
