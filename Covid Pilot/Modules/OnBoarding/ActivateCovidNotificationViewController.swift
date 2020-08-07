//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class ActivateCovidNotificationViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var router: AppRouter?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    var radarStatusUseCase: RadarStatusUseCase?
    @IBOutlet weak var activateButton: UIButton!
    
    
    @IBAction func onContinue(_ sender: Any) {
        self.view.showTransparentBackground(withColor: UIColor.blueyGrey90, alpha: 1, nil, "ACTIVATE_COVID_NOTIFICATION_POPUP_HOVER".localizedAttributed(), UIColor.white)
        radarStatusUseCase?.restoreLastStateAndSync().subscribe(
            onNext:{ [weak self] isTracingActive in
                self?.activationFinished()
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.activationFinished()
        }).disposed(by: disposeBag)
        
    }
    
    func activationFinished() {
        router?.route(to: .ActivatePush, from: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activateButton.setTitle("ALERT_HOME_COVID_NOTIFICATION_OK_BUTTON".localized, for: .normal)
    }
    
   

}
