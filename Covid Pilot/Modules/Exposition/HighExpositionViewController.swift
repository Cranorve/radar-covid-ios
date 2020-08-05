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
    @IBOutlet weak var covidWeb: UILabel!
    
    @IBOutlet weak var phoneViewVisibleConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneViewHiddenConstraint: NSLayoutConstraint!
    var since:Date?
    
    @IBOutlet weak var selectorView : BackgroundView!
    @IBOutlet weak var caSelectorButton: UIButton!
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var ccaUseCase: CCAAUseCase!
    var ccaArray:[CaData]?
    var pickerOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfectedText()
        expositionBGView.image = bgImageRed
        phoneView.isUserInteractionEnabled = true
        self.covidWeb.isUserInteractionEnabled = true
        self.covidWeb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onWebTap(tapGestureRecognizer:))))
        
        self.phoneLabel.isUserInteractionEnabled = true
        self.phoneLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))
        phoneView.image = UIImage(named: "WhiteCard")
                
        self.setCaSelector()
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
    
    @objc override func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        onWebTap(tapGestureRecognizer: tapGestureRecognizer, urlString: "EXPOSURE_HIGH_INFO_URL".localized)
    }
    
    
}
