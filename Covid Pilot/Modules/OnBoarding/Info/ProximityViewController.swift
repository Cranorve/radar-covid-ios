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
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?

    @IBAction func onContinue(_ sender: Any) {
        bluetoothUseCase?.checkBluetoothActive().subscribe(
            onNext: { [weak self] active in
                self?.navigateIf(active: active)
            }, onError: { error in
                debugPrint("Error activating bluetooth \(error)")
        })
        .disposed(by: disposeBag)
    }
    
    @IBAction func continueNoBluetooth(_ sender: Any) {
        navigateIf(active: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func navigateIf(active: Bool) {
        if (active) {
            onBoardingCompletedUseCase?.setOnboarding(completed: true)
            router?.route(to: Routes.Home, from: self)
        } else {
            
            let alert = Alert.showAlertOk(title:  "Bluetooth Inactivo", message: "Es necesario activar bluetooth para poder usar la aplicación", buttonTitle: "OK")
            
            present(alert, animated: true)
        }
    }



}
