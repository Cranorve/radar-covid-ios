//
//  LocalizationRepository.swift
//  Covid Pilot
//
//  Created by alopezh on 27/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol LocalizationRepository {
    func getCA() -> String?
    func setCA(_ ca: String)
    
    func getLocale() -> String?
    func setLocale(_ locale: String)
    
    func setTexts(_ texts: [String:String])
    func getTexts() -> [String:String]?

    func getCCAA() -> [String:String?]?
    func setCCAA(_ ccaa: [String:String?])
}

class UserDefaultsLocalizationRepository : LocalizationRepository {

    private static let kCA = "UserDefaultsLocalizationRepository.ca"
    private static let kLocale = "UserDefaultsLocalizationRepository.locale"
    private static let kTexts = "UserDefaultsLocalizationRepository.texts"
    private static let kCCAA = "UserDefaultsLocalizationRepository.kCCAA"
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: "es.gob.radarcovid") ?? UserDefaults.standard
    }
    
    func getCA() -> String? {
        userDefaults.object(forKey: UserDefaultsLocalizationRepository.kCA) as? String
    }
    
    func setCA(_ ca: String) {
        userDefaults.set(ca, forKey: UserDefaultsLocalizationRepository.kCA)
    }
    
    func getLocale() -> String? {
        userDefaults.object(forKey: UserDefaultsLocalizationRepository.kLocale) as? String
    }
    
    func setLocale(_ locale: String) {
         userDefaults.set(locale, forKey: UserDefaultsLocalizationRepository.kLocale)
    }
    
    func setTexts(_ texts: [String : String]) {
        userDefaults.set(texts, forKey: UserDefaultsLocalizationRepository.kTexts)
    }
    
    func getTexts() -> [String : String]? {
        userDefaults.object(forKey: UserDefaultsLocalizationRepository.kTexts) as? [String : String]
    }
    
    func getCCAA() -> [String : String?]? {
        userDefaults.object(forKey: UserDefaultsLocalizationRepository.kCCAA) as? [String : String]
    }
    
    func setCCAA(_ ccaa: [String : String?]) {
        userDefaults.set(ccaa, forKey: UserDefaultsLocalizationRepository.kCCAA)
    }
    
}
