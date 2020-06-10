//
//  RadarStatusUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class RadarStatusUseCase {
    
    func changeRadarStatus(active: Bool) -> Observable<Bool> {
        return .just(active)
    }
    
}
