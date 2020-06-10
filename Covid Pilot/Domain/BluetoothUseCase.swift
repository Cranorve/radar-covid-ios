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
    
    init(bluetoothHandler: BluetoothHandler) {
        self.bluetoothHandler = bluetoothHandler
    }
    
    func checkBluetoothActive() -> Observable<Bool> {
        bluetoothHandler.isActive()
        return .just(true)
    }
    
}
