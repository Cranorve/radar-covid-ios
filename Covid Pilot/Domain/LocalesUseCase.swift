//
//  LocalesUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 30/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class LocalesUseCase {
    
    private let localizationRepository: LocalizationRepository
    private let masterDataApi: MasterDataAPI
    
    private var locales: [String:String?]?
    
    init(localizationRepository: LocalizationRepository,
         masterDataApi: MasterDataAPI) {
        self.localizationRepository = localizationRepository
        self.masterDataApi = masterDataApi
    }
    
    public func loadLocales() -> Observable<[String:String?]> {
        let currentLocale = localizationRepository.getLocale()
        return masterDataApi.getLocales(locale: currentLocale).map { [weak self] masterLocales in
            var locales: [String:String?] = [:]
            masterLocales.forEach { loc in
                if let id = loc._id {
                    locales[id] = loc._description
                }
            }
            self?.locales = locales
            self?.localizationRepository.setLocales(locales)
            return locales
        }
    }
    
    public func getLocales() -> Observable<[String:String?]> {
        .deferred { [weak self] in
            if let locales = self?.locales {
                return .just(locales)
            }
            if let locales = self?.localizationRepository.getLocales() {
                return .just(locales)
            }
            return self?.loadLocales() ?? .empty()
        }
    }
    
    public func getCurrent() -> String? {
        localizationRepository.getLocale()
    }
    
    public func setCurrent(locale: String) {
        localizationRepository.setLocale(locale)
    }
}
