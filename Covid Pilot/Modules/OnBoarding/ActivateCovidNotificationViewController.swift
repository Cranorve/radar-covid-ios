//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class ActivateCovidNotificationViewController: UIViewController {
    
    var router: AppRouter?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    
    @IBOutlet weak var helpView: UIView!
    
    @IBAction func onContinue(_ sender: Any) {
        self.helpView.isHidden = false
        self.helpView.fadeIn(0.9)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
            guard let this = self else {
                return
            }
            this.router?.route(to: .ActivatePush, from: this)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   

}
