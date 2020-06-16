//
//  ConfiguratioUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 16/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

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
        .deferred {
            
            if let settings = self.settingsRepository.getSettings() {
                return .just(settings)
            }
            
            return .zip(self.tokenApi.getUuid(),
                        self.settingsApi.getSettings()) { token, settings in
                    let settings = Settings()
                        settings.udid = token.uuid
                            self.settingsRepository.save(settings: settings)
                    return settings
            }
        }
    }
    
}
