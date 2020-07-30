//
//  ProximityViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class ProximityViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    var router: AppRouter?
    var radarStatusUseCase: RadarStatusUseCase?

    @IBAction func onContinue(_ sender: Any) {
        if radarStatusUseCase!.isTracingInit() {
            router!.route(to: .ActivatePush, from: self)
        } else {
            router!.route(to: .ActivateCovid, from: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
