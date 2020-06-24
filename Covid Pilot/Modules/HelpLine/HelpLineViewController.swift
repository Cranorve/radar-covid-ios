//
//  HelpLineViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import MessageUI

class HelpLineViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var router: AppRouter?
    var preferencesRepository: PreferencesRepository?
    
    @IBOutlet weak var infoLabel: UILabel!
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
        
        infoLabel.isUserInteractionEnabled = true
        infoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onEmailTap(tapGestureRecognizer:))))
        
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: Config.contactNumber)
    }
    
    @objc func onEmailTap(tapGestureRecognizer: UITapGestureRecognizer) {
        let email = Config.contactEmail
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p></p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
