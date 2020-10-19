//

// Copyright (c) 2020 Gobierno de España
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
// SPDX-License-Identifier: MPL-2.0
//

import Foundation

protocol LocalizationRepository {
    
    func getLocale() -> String?
    func setLocale(_ locale: String)
    
    func getLocales() -> [ItemLocale]?
    func setLocales(_ locales: [ItemLocale])
    
    func setTexts(_ texts: [String: String])
    func getTexts() -> [String: String]?
    
    func setCurrent(ca: CaData)
    func getCurrentCA() -> CaData?
}

class UserDefaultsLocalizationRepository: LocalizationRepository {
    
    private static let kLocale = "UserDefaultsLocalizationRepository.locale"
    private static let kLocales = "UserDefaultsLocalizationRepository.kLocales"
    private static let kTexts = "UserDefaultsLocalizationRepository.texts"
    private static let kCCAA = "UserDefaultsLocalizationRepository.kCCAA"
    private static let kCurrentCA = "UserDefaultsLocalizationRepository.kCurrentCa"
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: Bundle.main.bundleIdentifier) ?? UserDefaults.standard
    }
    
    func getLocale() -> String? {
        userDefaults.object(forKey: UserDefaultsLocalizationRepository.kLocale) as? String ?? self.getLocales()?
            .filter({ (itemLocale) -> Bool in
                itemLocale.id.contains("es")
            }).first?.id
    }
    
    func setLocale(_ locale: String) {
        userDefaults.set(locale, forKey: UserDefaultsLocalizationRepository.kLocale)
    }
    
    func setTexts(_ texts: [String: String]) {
        userDefaults.set(texts, forKey: UserDefaultsLocalizationRepository.kTexts)
    }
    
    func getTexts() -> [String: String]? {
        userDefaults.object(forKey: UserDefaultsLocalizationRepository.kTexts) as? [String: String]
    }
    
    func getCurrentCA() -> CaData? {
        try? PropertyListDecoder().decode(CaData.self,
                                          from: userDefaults.object(forKey: UserDefaultsLocalizationRepository.kCurrentCA) as? Data ?? Data())
    }
    
    func setCurrent(ca: CaData) {
        let data = try? PropertyListEncoder().encode(ca)
        userDefaults.set(data, forKey: UserDefaultsLocalizationRepository.kCurrentCA)
    }
    
    func getLocales() -> [ItemLocale]? {
        if let dLocales = userDefaults.object(forKey: UserDefaultsLocalizationRepository.kLocales) as? [String: String?] {
            return ItemLocale.mappertToDic(dic: dLocales)
        } else if let dataLocales = userDefaults.object(forKey: UserDefaultsLocalizationRepository.kLocales) as? Data {    
            let locales = try! JSONDecoder().decode(Locales.self, from: dataLocales)
            return locales.itemLocales
        }
        return nil
    }
    
    func setLocales(_ locale: [ItemLocale]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Locales.init(itemLocales: locale)) {
            userDefaults.set(encoded, forKey: UserDefaultsLocalizationRepository.kLocales)
        }
    }
    
}
