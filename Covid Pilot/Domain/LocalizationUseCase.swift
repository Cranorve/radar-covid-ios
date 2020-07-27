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
    private let localizationApi: LanguageApi

    
//    private let localizationRepository: LocalizationRepository
    
    private var _localizationMap: [String : String]?
    
    var localizationMap: [String : String]? {
        get {
            _localizationMap
        }
    }
    
    init(settingsApi: SettingsAPI, localizationApi: LanguageApi) {
        self.settingsApi = settingsApi
        self.localizationApi = localizationApi
    }
    
    func loadlocalization() -> Observable<[String : String]?> {
        return Observable.create { (subscriber) -> Disposable in
            self.localizationApi.getLanguageWithLocale().responseJSON { (response) in
                switch response.result {
                    case .failure(let err):
                        print("failled err", err)
                    case .success(let response):
                        guard let responseJSON = response as? NSDictionary,
                            let includes = responseJSON.value(forKey: "includes") as? NSDictionary,
                            let entryArray = includes.value(forKey: "Entry") as? Array<NSDictionary>
                            else {
                                return subscriber.onNext([:])
                        }
                        var keysArray: [String: String] = [:]
                        entryArray.forEach { (entry) in
                            guard let fields = entry.value(forKey: "fields") as? [String: String] else {
                                return subscriber.onNext([:])
                            }
                            let finalFields = fields.filter{ $0.key != "id" }
                            finalFields.forEach{ f in
                                keysArray[f.key] = f.value
                            }
                        }
                        self._localizationMap = keysArray
                        return subscriber.onNext(keysArray)
                    
                }
            }
            return Disposables.create();
        }
    }
    
}
