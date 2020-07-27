//
//  HelpLineViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import MessageUI
import RxSwift

class HelpLineViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var router: AppRouter?
    var preferencesRepository: PreferencesRepository?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var timeTableLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var one_more_step_2: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var one_more_step_3: UILabel!
    @IBOutlet weak var phoneView: BackgroundView!
    
    override func viewWillAppear(_ animated: Bool) {
        loadTexts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))

        timeTableLabel.text = Config.timeTable
        phoneNumberLabel.attributedText = "CONTACT_PHONE".localizedAttributed()
        phoneView.image = UIImage(named: "WhiteCard")
        
        infoLabel.isUserInteractionEnabled = true
        infoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onEmailTap(tapGestureRecognizer:))))
        
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: "CONTACT_PHONE".localized)
    }
    
    @objc func onEmailTap(tapGestureRecognizer: UITapGestureRecognizer) {
        let email = "CONTACT_EMAIL".localized
        
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
    
    private func loadTexts() {
        reportLabel.attributedText = "HELP_LINE_PHONE_PARAGRAPH_1".localizedAttributed
        infoLabel.attributedText = "HELP_LINE_ONE_MORE_STEP_PARAGRAPH_1".localizedAttributed
        one_more_step_2.attributedText = "HELP_LINE_ONE_MORE_STEP_PARAGRAPH_2".localizedAttributed
        one_more_step_3.attributedText = "HELP_LINE_ONE_MORE_STEP_PARAGRAPH_3".localizedAttributed
        lblEmail.attributedText = "CONTACT_EMAIL".localizedAttributed()
        
        
    }

}
