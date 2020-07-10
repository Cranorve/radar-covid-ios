//
//  PreferencesRepository.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol PreferencesRepository {
    func isOnBoardingCompleted()-> Bool
    func setOnboarding(completed: Bool)
    
    func isPollCompleted() -> Bool
    func setPoll(completed: Bool)
    
    func isTracingActive() -> Bool
    func setTracing(active: Bool)
    
    func getLastSync() -> Date?
    func setLastSync(date: Date)
}

class UserDefaultsPreferencesRepository : PreferencesRepository {

    private static let kOnboarding = "UserDefaultsPreferencesRepository.onboarding"
    private static let kPoll = "UserDefaultsPreferencesRepository.poll"
    private static let kTracing = "UserDefaultsPreferencesRepository.tracing"
    private static let kSyncDate = "UserDefaultsPreferencesRepository.syncDate"
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: "es.gob.radarcovid") ?? UserDefaults.standard
    }
    
    
    func isOnBoardingCompleted() -> Bool {
        userDefaults.object(forKey: UserDefaultsPreferencesRepository.kOnboarding) as? Bool ?? false
    }
    
    func setOnboarding(completed: Bool) {
        userDefaults.set(completed, forKey: UserDefaultsPreferencesRepository.kOnboarding)
    }
    
    func isTracingActive() -> Bool {
        userDefaults.object(forKey: UserDefaultsPreferencesRepository.kTracing) as? Bool ?? true
    }
    
    func setTracing(active: Bool) {
        userDefaults.set(active, forKey: UserDefaultsPreferencesRepository.kTracing)
    }

    func isPollCompleted() -> Bool {
        userDefaults.object(forKey: UserDefaultsPreferencesRepository.kPoll) as? Bool ?? false
    }
    
    func setPoll(completed: Bool) {
        userDefaults.set(completed, forKey: UserDefaultsPreferencesRepository.kPoll)
    }
    
    func getLastSync() -> Date? {
        userDefaults.object(forKey: UserDefaultsPreferencesRepository.kSyncDate) as? Date
    }
    
    func setLastSync(date: Date) {
        userDefaults.set(date, forKey: UserDefaultsPreferencesRepository.kSyncDate)
    }
    
}
