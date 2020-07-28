//
//  CCAAUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 27/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class CCAAUseCase {
    
    private var ccaa: [String:String?]?
    private let masterDataApi: MasterDataAPI
    private let localizationRepository: LocalizationRepository
    
    init(masterDataApi: MasterDataAPI, localizationRepository: LocalizationRepository) {
        self.masterDataApi = masterDataApi
        self.localizationRepository = localizationRepository
    }
    
    public func loadCCAA() -> Observable<[String:String?]> {
        masterDataApi.getCcaa().map { [weak self] values in
            var ccaa : [String:String?] = [:]
            values.forEach { v in
                if let id = v._id {
                    ccaa[id] = v._description
                }
            }
            self?.localizationRepository.setCCAA(ccaa)
            return ccaa
        }
    }
    
    public func getCCAA() -> Observable<[String:String?]> {
        .deferred { [weak self] in
            if let ccaa = self?.ccaa {
                return .just(ccaa)
            }
            if let ccaa = self?.localizationRepository.getCCAA() {
                return .just(ccaa)
            }
            return self?.loadCCAA() ?? .empty()
        }

    }
    
}
