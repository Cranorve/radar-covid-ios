//
//  ConfigurationRepository.swift
//  Covid Pilot
//
//  Created by alopezh on 16/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol SettingsRepository {
    func getSettings()-> Settings?

    func save(settings: Settings?)
}

class UserDefaultsSettingsRepository : SettingsRepository {
    
    private static let kData = "UserDefaultsSettingsRepository.settings"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: "es.gob.radarcovid") ?? UserDefaults.standard
    }
    
    func getSettings() -> Settings? {
        let uncoded = userDefaults.data(forKey: UserDefaultsSettingsRepository.kData) ?? Data()
        if (uncoded.isEmpty) {
            return nil
        }
        return try? decoder.decode(Settings.self, from: uncoded)
    }
    
    func save(settings: Settings?) {
        let encoded = try! encoder.encode(settings)
        userDefaults.set(encoded, forKey: UserDefaultsSettingsRepository.kData)
    }
    
    
}
