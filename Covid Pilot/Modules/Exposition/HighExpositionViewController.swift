//
//  HighExpositionViewController.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 11/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class HighExpositionViewController: BaseExposed {
    
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    
    @IBOutlet weak var podriasestar: UILabel!
    @IBOutlet weak var infectedText: UILabel!
    @IBOutlet weak var phoneView: BackgroundView!
    @IBOutlet weak var timeTableLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    var since:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfectedText()
        
        expositionBGView.image = bgImageRed
        
      
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))
        phoneView.image = UIImage(named: "WhiteCard")
        phoneLabel.attributedText = "CONTACT_PHONE".localizedAttributed()
        timeTableLabel.text = Config.timeTable
        super.viewDidLoad()
    }
    
    func setInfectedText() {
        let date = self.since ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let actualizado = formatter.string(from: date)
        var daysSinceLastInfection = Date().days(sinceDate: since ?? Date()) ?? 1
        if daysSinceLastInfection == 0 {
            daysSinceLastInfection = 1
        }
        podriasestar.attributedText = "EXPOSITION_HIGH_DESCRIPTION".localizedAttributed(withParams: [String(daysSinceLastInfection), actualizado])
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: "CONTACT_PHONE".localized)
    }
    

   
    
}
