//
//  FinishPollViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import MessageUI

class FinishPollViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneView: BackgroundView!
    
    @IBOutlet weak var timeTableLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))

        timeTableLabel.text = Config.timeTable
        phoneNumberLabel.text = Config.contactNumber
        
        phoneView.image = UIImage(named: "WhiteCard")
        
        emailLabel.isUserInteractionEnabled = true
        emailLabel.addGestureRecognizer(  UITapGestureRecognizer(target: self, action: #selector(onEmailTap(tapGestureRecognizer:)))  )
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
