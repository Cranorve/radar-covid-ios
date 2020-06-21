//
//  FinishPollViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class FinishPollViewController: UIViewController {
    
    @IBOutlet weak var phoneView: BackgroundView!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var router: AppRouter?

    @IBAction func onHome(_ sender: Any) {
        router?.route(to: .Home, from: self)
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
