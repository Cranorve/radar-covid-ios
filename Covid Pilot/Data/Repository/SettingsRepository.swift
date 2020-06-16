//
//  ConfigurationRepository.swift
//  Covid Pilot
//
//  Created by alopezh on 16/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol ConfigurationRepository {
    func getConfiguration()-> Config?

    func saveConfiguration(completed: Config?)
}

class UserDefaultsConfigurationRepository : ConfigurationRepository {
    
}
