//
//  MyDataViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class MyDataViewController: UIViewController {

    @IBOutlet weak var acceptTermsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var bullet2: UILabel!
    @IBOutlet weak var bullet3: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTexts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acceptTermsLabel.isUserInteractionEnabled = true
        privacyLabel.isUserInteractionEnabled = true
        
        acceptTermsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapTerms(tapGestureRecognizer:))))
        
        privacyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapPrivacy(tapGestureRecognizer:))))
    }
    
    @objc func userDidTapTerms(tapGestureRecognizer: UITapGestureRecognizer) {
        onWebTap(tapGestureRecognizer: tapGestureRecognizer, urlString: "USE_CONDITIONS_URL".localized)
    }
    
    @objc func userDidTapPrivacy(tapGestureRecognizer: UITapGestureRecognizer) {
        onWebTap(tapGestureRecognizer: tapGestureRecognizer, urlString: "PRIVACY_POLICY_URL".localized)
    }
    
    private func loadTexts() {

        descriptionLabel.attributedText = "MY_DATA_BULLET_1".localizedAttributed
        bullet2.attributedText = "MY_DATA_BULLET_2".localizedAttributed
        bullet3.attributedText = "MY_DATA_BULLET_3".localizedAttributed

        privacyLabel.attributedText = "MY_DATA_PRIVACY".localizedAttributed        
   
        acceptTermsLabel.attributedText = "MY_DATA_TERMS".localizedAttributed
    }
    
}
