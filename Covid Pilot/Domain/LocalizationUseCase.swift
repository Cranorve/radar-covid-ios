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
    
//    private let localizationRepository: LocalizationRepository
    
    private var _localizationMap: [String : String]?
    
    var localizationMap: [String : String]? {
        get {
            _localizationMap
        }
    }
    
//    init(localizationRepository: LocalizationRepository) {
//        self.localizationRepository = localizationRepository
//    }
    
    func loadlocalization() -> Observable<[String : String]?> {
        Observable.just(mockService()).delay(.seconds(5), scheduler: <#SchedulerType#>)

    }
    
    private func mockService() -> [String : String] {
        ["title" : "Este es un titulo traducido"]
    }
    
}
