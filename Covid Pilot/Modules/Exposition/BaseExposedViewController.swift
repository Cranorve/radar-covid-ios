//
//  BaseExposedViewController.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 30/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

protocol ExpositionView {
    func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer)
}

class BaseExposed: UIViewController, ExpositionView {

    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var expositionBGView : BackgroundView!
    var lastCheck:Date?

    override func viewDidLoad() {
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
        
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {

    }
    
   
}

