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
    
    @IBOutlet weak var telephoneAsistant: UILabel!
    @IBOutlet weak var timeTableLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedString = NSMutableAttributedString(string: "Contacta con nosotros si tu riesgo de exposición en la aplicación es alto o si tienes cualquier incidencia sobre la aplicación.", attributes: [
          .font: UIFont(name: "Muli-Light", size: 16.0)!,
          .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-SemiBold", size: 16.0)!, range: NSRange(location: 22, length: 51))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-SemiBold", size: 16.0)!, range: NSRange(location: 96, length: 10))
        telephoneAsistant.attributedText = attributedString
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))

        timeTableLabel.text = Config.timeTable
        phoneNumberLabel.text = Config.contactNumber
        
        phoneView.image = UIImage(named: "WhiteCard")
//        
//        emailLabel.isUserInteractionEnabled = true
//        emailLabel.addGestureRecognizer(  UITapGestureRecognizer(target: self, action: #selector(onEmailTap(tapGestureRecognizer:)))  )
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
