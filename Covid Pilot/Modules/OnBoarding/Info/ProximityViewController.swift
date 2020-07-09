//
//  ProximityViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class ProximityViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var router: AppRouter?
    var bluetoothUseCase: BluetoothUseCase?

    @IBAction func onContinue(_ sender: Any) {
//        bluetoothUseCase?.checkBluetoothActive().subscribe(
//            onNext: { [weak self] active in
//                self?.navigateIf(active: active)
//            }, onError: { error in
//                debugPrint("Error activating bluetooth \(error)")
//        })
//        .disposed(by: disposeBag)
        router?.route(to: .ActivateCovid, from: self)
    }
    
//    @IBAction func continueNoBluetooth(_ sender: Any) {
////        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
//        navigateIf(active: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func navigateIf(active: Bool) {
        if (active) {
            router?.route(to: Routes.Home, from: self)
        } else {
            
            self.showAlertOk(title:  "Bluetooth Inactivo", message: "Es necesario activar bluetooth para poder usar la aplicación", buttonTitle: "OK")
        }
    }



}
