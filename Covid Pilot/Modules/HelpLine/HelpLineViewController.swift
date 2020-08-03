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

    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneView: BackgroundView!
    
    override func viewWillAppear(_ animated: Bool) {
        loadTexts()
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))

        timeTableLabel.text = Config.timeTable
        phoneNumberLabel.attributedText = "CONTACT_PHONE".localizedAttributed()
        phoneView.image = UIImage(named: "WhiteCard")
        
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: "CONTACT_PHONE".localized)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func loadTexts() {
        reportLabel.attributedText = "HELP_LINE_PHONE_PARAGRAPH_1".localizedAttributed

    }

}
