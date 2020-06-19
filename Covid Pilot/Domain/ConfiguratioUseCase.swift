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
                    self?.settingsRepository.save(settings: settings)
                    return settings
                }.flatMap { (config) -> Observable<Settings> in
                    self?.sync(config) ?? .empty()
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
    
    private func sync(_ settings: Settings) -> Observable<Settings> {
        .create { [weak self] observer in
            
            self?.loadParameters(settings)
            
            DP3TTracing.sync { result in
                switch result {
                case let .failure(error):
                    // TODO: tratar los distintos casos de error
                    observer.onError(error)
                default:
                    observer.onNext(settings)
                }
            }
            return Disposables.create()
        }
    }
    
    private func loadParameters(_ settings: Settings) {
        var params = DP3TTracing.parameters
        if let lower = settings.parameters?.exposureConfiguration?.attenuation?.riskLevelValue1 {
            params.contactMatching.lowerThreshold = lower
        }
        if let higher = settings.parameters?.exposureConfiguration?.attenuation?.riskLevelValue2 {
            params.contactMatching.higherThreshold = higher
        }
        DP3TTracing.parameters = params
    }
    
}
