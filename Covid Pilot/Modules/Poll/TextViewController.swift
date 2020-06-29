//
//  TextViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 20/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITextViewDelegate, QuestionController {
    
    var question: Question?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.clipsToBounds = true;
        textView.layer.cornerRadius = 10.0;
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    
    }
    
    func textViewDidChange(_ textView: UITextView) {
        question?.valuesSelected = [textView.text]
    }

    
    
}
