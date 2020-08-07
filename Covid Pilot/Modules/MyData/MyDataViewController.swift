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
    
    
}
