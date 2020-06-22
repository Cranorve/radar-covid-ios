//
//  HelpLineViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class HelpLineViewController: UIViewController {
    
    var router: AppRouter?
    var preferencesRepository: PreferencesRepository?
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneView: BackgroundView!
    
    @IBAction func onPollSelected(_ sender: Any) {
        if preferencesRepository?.isPollCompleted() ?? false {
            router?.route(to: Routes.PollFinished, from: self)
        } else {
            router?.route(to: Routes.Poll, from: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))

        
        phoneNumberLabel.text = Config.contactNumber
        phoneView.image = UIImage(named: "WhiteCard")
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: Config.contactNumber)
    }

}
