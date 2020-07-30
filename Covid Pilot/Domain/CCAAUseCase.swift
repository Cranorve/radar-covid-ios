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
    
    private var ccaa: [CaData]?
    private let masterDataApi: MasterDataAPI
    private let localizationRepository: LocalizationRepository
    
    init(masterDataApi: MasterDataAPI, localizationRepository: LocalizationRepository) {
        self.masterDataApi = masterDataApi
        self.localizationRepository = localizationRepository
    }
    
    public func loadCCAA() -> Observable<[CaData]> {
        masterDataApi.getCcaa().map { [weak self] values in
            var ccaa : [CaData] = []
            values.forEach { v in
                if let ca = self?.mapCa(v) {
                    ccaa.append(ca)
                }
            }
            self?.ccaa = ccaa
            self?.localizationRepository.setCCAA(ccaa)
            return ccaa
        }
    }
    
    public func getCCAA() -> Observable<[CaData]> {
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
    
    public func getCurrent() -> CaData? {
        localizationRepository.getCurrent()
    }
    
    public func setCurrent(ca: CaData) {
        localizationRepository.setCurrent(ca: ca)
    }
    
    private func mapCa(_ caDto: CcaaKeyValueDto) -> CaData {
        CaData(id: caDto._id, description: caDto._description, phone: caDto.phone, email: caDto.email, additionalInfo: caDto.additionalInfo)
    }
    
}
