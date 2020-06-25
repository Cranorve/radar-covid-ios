//
//  RatingViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController, QuestionController {
    
    @IBOutlet weak var options: UISegmentedControl!
    
    @IBAction func onSelected(_ sender: Any) {
        question?.valuesSelected = [options.titleForSegment(at: options.selectedSegmentIndex) ]
    }
    
    var question: Question?
    private var items : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValues()
    }
    
    private func loadValues() {
        var position = 0
        options.removeAllSegments()
        options.selectedSegmentTintColor = #colorLiteral(red: 0.5410000086, green: 0.4860000014, blue: 0.7179999948, alpha: 1)
        options.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        for index in (question?.minValue ?? 1) ... (question?.maxValue ?? 1) {
            
            
            options.insertSegment(withTitle: index.description, at: position, animated: false)
            
            position += 1
        }
        if let selected = question?.valuesSelected?.first {
            options.selectedSegmentIndex = selected as? Int ?? 0
        }
        
    }

}
