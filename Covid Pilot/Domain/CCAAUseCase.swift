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
    
    private let masterDataApi: MasterDataAPI
    
    init(masterDataApi: MasterDataAPI) {
        self.masterDataApi = masterDataApi
    }
    
    public func getCCAA() -> Observable<[String:String?]> {
        masterDataApi.getCcaa().map { values in
            var ccaa : [String:String?] = [:]
            values.forEach { v in
                if let id = v._id {
                    ccaa[id] = v._description
                }
            }
            return ccaa
        }
    }
    
}
