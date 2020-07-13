//
//  ExpositionInfoRepository.swift
//  Covid Pilot
//
//  Created by alopezh on 02/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol ExpositionInfoRepository {
    func getExpositionInfo() -> ExpositionInfo?
    func save(expositionInfo: ExpositionInfo)
    func clearData()
}

class UserDefaultsExpositionInfoRepository : ExpositionInfoRepository {

    private static let kData = "UserDefaultsExpositionInfoRepository.expositionInfo"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: "es.gob.radarcovid") ?? UserDefaults.standard
    }
    
    func getExpositionInfo() -> ExpositionInfo? {
        if let uncoded = userDefaults.data(forKey: UserDefaultsExpositionInfoRepository.kData), !uncoded.isEmpty {
            return try? decoder.decode(ExpositionInfo.self, from: uncoded)
        }
        return nil
    }
    
    func save(expositionInfo: ExpositionInfo) {
        let encoded = try! encoder.encode(expositionInfo)
        userDefaults.set(encoded, forKey: UserDefaultsExpositionInfoRepository.kData)
    }
    

    func clearData() {
        userDefaults.removeObject(forKey: UserDefaultsExpositionInfoRepository.kData)
    }

    
    
}

