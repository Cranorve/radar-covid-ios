//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class ActivatePushNotificationViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var router: AppRouter?
    
    var notificationHandler: NotificationHandler?
    @IBAction func onContinue(_ sender: Any) {

        
        self.view.showTransparentBackground(withColor: UIColor.blueyGrey90, alpha: 1, nil, "ACTIVATE_PUSH_NOTIFICATION_POPUP_HOVER".localizedAttributed(), UIColor.white)
        
        self.notificationHandler?.setupNotifications().subscribe(onNext: { [weak self] accepted in
            print("notification accepted", accepted)
            DispatchQueue.main.async {
                self?.navigateHome()
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func navigateHome() {
         router?.route(to: .Home, from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   

}
