//
//  PreferencesRepository.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol PreferencesRepository {
    func isOnBoardingCompleted()-> Bool?

    func setOnboarding(completed: Bool)
}

class UserDefaultsPreferencesRepository : PreferencesRepository {
    
    private static let kData = "UserDefaultsPreferencesRepository.kData"
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: "com.minsait.mobile.sedia") ?? UserDefaults.standard
    }
    
    
    func isOnBoardingCompleted() -> Bool? {
         userDefaults.object(forKey: UserDefaultsPreferencesRepository.kData) as? Bool
    }
    
    func setOnboarding(completed: Bool) {
        userDefaults.set(completed, forKey: UserDefaultsPreferencesRepository.kData)
    }
    
}
