//
//  PositiveExposed.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 06/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class PositiveExposedViewController: BaseExposed {
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    
    @IBOutlet weak var realInfectedText: UILabel!
    var since:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfectedText()
        
        expositionBGView.image = bgImageRed
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
        realInfectedText.attributedText = "EXPOSITION_EXPOSED_DESCRIPTION".localizedAttributed(withParams: [String(daysSinceLastInfection), actualizado])
    }
    
    
    
}
