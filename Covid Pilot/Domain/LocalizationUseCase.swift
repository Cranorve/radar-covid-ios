//
//  LocalizationUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class LocalizationUseCase: LocalizationSource {
    
    private let settingsApi: SettingsAPI
    
//    private let localizationRepository: LocalizationRepository
    
    private var _localizationMap: [String : String]?
    
    var localizationMap: [String : String]? {
        get {
            _localizationMap
        }
    }
    
    init(settingsApi: SettingsAPI) {
        self.settingsApi = settingsApi
    }
    
    func loadlocalization() -> Observable<[String : String]?> {
        settingsApi.getSettings().map { [weak self] settinngs in
            self?._localizationMap = self?.mockService()
            return self?._localizationMap
        }.catchError { [weak self] _ in
            self?._localizationMap = self?.mockService()
            return .just(self?._localizationMap)
        }
    }
    
    private func mockService() -> [String : String] {
        ["title" : "Este es un titulo traducido",
         "communicateButton": "Comunica tu positivo COOOOVID-19"]
    }
    
}
