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

class UserDefaultsConfigurationRepository : SettingsRepository {
    func getSettings() -> Settings? {
        Settings()
    }
    
    func save(settings: Settings?) {
        
    }
    
    
}
