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
        textView.text = "Describir...";
        textView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        endEditingTextView()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describir..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        question?.valuesSelected = [textView.text]
    }
    
    func endEditingTextView(){
        textView.endEditing(true)
    }

    
    
}
