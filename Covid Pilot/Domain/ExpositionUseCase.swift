//
//  ExpositionUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class ExpositionUseCase {
    
    func getExpositionInfo() -> Observable<ExpositionInfo> {
        let exposition = ExpositionInfo(level: ExpositionInfo.Level.LOW)
        return .just(exposition)
    }
    
}
