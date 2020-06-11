//
//  BluetoothHandler.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift

protocol BluetoothHandler {
    func isActive() -> Observable<Bool>
}

class CentralManagerBluetoothHandler: NSObject, BluetoothHandler, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager?
    var observerList: [AnyObserver<Bool>] = []
    
    func isActive() -> Observable<Bool> {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        return .create { [weak self] observer in
            self?.observerList.append(observer)
            return Disposables.create()
        }
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
        notify(state: active)
        
    }
    
    private func notify(state: Bool) {
        observerList.forEach { observer in
            observer.onNext(state)
            observer.onCompleted()
        }
    }
    
}
