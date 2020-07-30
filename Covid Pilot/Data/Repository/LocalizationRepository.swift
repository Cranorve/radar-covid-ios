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

    func getCCAA() -> [CaData]?
    func setCCAA(_ ccaa: [CaData])
    
    func setCurrent(ca: CaData)
    func getCurrent() -> CaData?
}

class UserDefaultsLocalizationRepository : LocalizationRepository {

    private static let kCA = "UserDefaultsLocalizationRepository.ca"
    private static let kLocale = "UserDefaultsLocalizationRepository.locale"
    private static let kTexts = "UserDefaultsLocalizationRepository.texts"
    private static let kCCAA = "UserDefaultsLocalizationRepository.kCCAA"
    private static let kCurrentCA = "UserDefaultsLocalizationRepository.kCurrentCa"

    
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
    
    func getCCAA() -> [CaData]? {
        try? PropertyListDecoder().decode([CaData].self, from: userDefaults.object(forKey: UserDefaultsLocalizationRepository.kCCAA) as? Data ?? Data())
    }
    
    func setCCAA(_ ccaa: [CaData]) {
        let data = try? PropertyListEncoder().encode(ccaa)
        userDefaults.set(data, forKey: UserDefaultsLocalizationRepository.kCCAA)
    }
    
    func getCurrent() -> CaData? {
        try? PropertyListDecoder().decode(CaData.self, from: userDefaults.object(forKey: UserDefaultsLocalizationRepository.kCurrentCA) as? Data ?? Data())
    }
    
    func setCurrent(ca: CaData) {
        let data = try? PropertyListEncoder().encode(ca)
        userDefaults.set(data, forKey: UserDefaultsLocalizationRepository.kCurrentCA)
    }
    
}
