//
//  BluetoothUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class BluetoothUseCase {
    
    private let bluetoothHandler: BluetoothHandler
    
    private let preferencesRepository: PreferencesRepository
    
    init(bluetoothHandler: BluetoothHandler, preferencesRepository: PreferencesRepository) {
        self.bluetoothHandler = bluetoothHandler
        self.preferencesRepository = preferencesRepository
    }
    
    func checkBluetoothActive() -> Observable<Bool> {
        preferencesRepository.setTracing(active: true)
        return bluetoothHandler.isActive()
    }
    
}
