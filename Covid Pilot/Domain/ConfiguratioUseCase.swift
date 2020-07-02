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
    
    init(settingsRepository: SettingsRepository,
         tokenApi: TokenAPI,
         settingsApi: SettingsAPI) {
        self.settingsRepository = settingsRepository
        self.tokenApi = tokenApi
        self.settingsApi = settingsApi
    }
    
    func getConfig() -> Observable<Settings> {
        .deferred { [weak self] in
            Observable<Settings>.zip(self?.getUuid() ?? .empty(),
                        self?.settingsApi.getSettings() ?? .empty() ) { token, backSettings in
                    let settings = Settings()
                    settings.udid = token
                    settings.parameters = backSettings
                    self?.loadParameters(settings)
                    self?.settingsRepository.save(settings: settings)
                    return settings
                }
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
        DP3TTracing.parameters = params
    }
    
}
