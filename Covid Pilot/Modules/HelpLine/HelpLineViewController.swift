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

    @IBOutlet weak var phoneView: BackgroundView!
    @IBOutlet weak var faqWebLabel: UILabel!
    @IBOutlet weak var infoWebLabel: UILabel!
    @IBOutlet weak var otherWebLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneView.image = UIImage(named: "WhiteCard")
        
        faqWebLabel.isUserInteractionEnabled = true
        faqWebLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onWebTap(tapGestureRecognizer:))))
        
        infoWebLabel.isUserInteractionEnabled = true
        infoWebLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onWebTap(tapGestureRecognizer:))))
        
        otherWebLabel.isUserInteractionEnabled = true
        otherWebLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onWebTap(tapGestureRecognizer:))))
        
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: "CONTACT_PHONE".localized)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
