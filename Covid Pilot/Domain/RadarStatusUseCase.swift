//
//  RadarStatusUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import DP3TSDK
import Foundation
import RxSwift

class RadarStatusUseCase {
    
    func changeRadarStatus(active: Bool) -> Observable<Bool> {
        return .create { observer in
            if (active) {
                try? DP3TTracing.startTracing()
                observer.onNext(true)
            } else if (!active) {
                DP3TTracing.stopTracing()
                observer.onNext(false)
            } //else {observer.onError("Error parsing push repository data")}
            
            return Disposables.create()
        }
        
    }
    
}
