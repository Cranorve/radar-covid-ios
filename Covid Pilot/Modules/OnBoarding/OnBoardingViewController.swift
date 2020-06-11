//
//  OnBoardingViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    var router: AppRouter?

    @IBAction func onOk(_ sender: Any) {
        router?.route(to: Routes.Terms, from:self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        if (onBoardingCompletedUseCase?.isOnBoardingCompleted() ?? false) {
//            router?.route(to: Routes.Home, from: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
