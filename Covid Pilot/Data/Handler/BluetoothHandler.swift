//
//  BluetoothHandler.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BluetoothHandler {
    func isActive() -> Bool
}

class CentralManagerBluetoothHandler: NSObject, BluetoothHandler, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager?
    
    
    func isActive() -> Bool {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        return true
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        var active: Bool = false
        
        switch central.state {

        case .unauthorized:
            switch central.authorization {
                case .allowedAlways:
                    active = false
                case .denied:
                    active = false
                case .restricted:
                    active = false
                case .notDetermined:
                    active = false
                @unknown default:
                   active = false
                }
        case .unknown:
            active = false
        case .unsupported:
            active = false
        case .poweredOn:
            active = true
        case .poweredOff:
            active = false
        case .resetting:
            active = false
        @unknown default:
            active = false
        }
    }
    
}
