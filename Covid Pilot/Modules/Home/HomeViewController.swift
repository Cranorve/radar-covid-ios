//
//  HomeViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var router: AppRouter?
    var expositionUseCase: ExpositionUseCase?
    
    @IBAction func onCommunicate(_ sender: Any) {
        router?.route(to: Routes.MyHealth, from: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] charts in

            }, onError: {  [weak self] error in

        }).disposed(by: disposeBag)
        
    }
    

    

}
