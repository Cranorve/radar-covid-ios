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
    
    var bluetoothUseCase: BluetoothUseCase?
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var nextDelegate: NextDelegate?

    @IBAction func onContinue(_ sender: Any) {
        bluetoothUseCase?.checkBluetoothActive().subscribe(
            onNext: { [weak self] active in
                self?.navigateIf(active: active)
            }, onError: {  [weak self] error in
//                TODO: Alert!
        })
        .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 2
        view.bringSubviewToFront(pageControl)
    }
    
    private func navigateIf(active: Bool) {
        if (active) {
            nextDelegate?.next()
        } else {
            
            let alert = Alert.showAlertOk(title:  "Bluetooth Inactivo", message: "Es necesario activar bluetooth para poder usar la aplicación", buttonTitle: "OK")
            
            present(alert, animated: true)
        }
    }



}
