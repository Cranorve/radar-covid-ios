//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class ActivatePushNotificationViewController: UIViewController {
    
    var router: AppRouter?
    
    @IBOutlet weak var helpView: UIView!
    var notificationHandler: NotificationHandler?
    @IBAction func onContinue(_ sender: Any) {
        self.helpView.isHidden = false
        self.helpView.fadeIn(0.9)
        self.notificationHandler?.setupNotifications().subscribe(onNext: { (accepted) in
            print("notification accepted", accepted)
            DispatchQueue.main.async {
                self.router?.route(to: .Home, from: self)
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   

}
