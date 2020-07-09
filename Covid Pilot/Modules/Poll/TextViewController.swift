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
    
    override func viewWillDisappear(_ animated: Bool) {
        endEditingTextView()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        //resize textEditor
        let constraint = self.textView.constraints.first(where: {$0.identifier == "textViewHeigh"})
        constraint?.constant = 100
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describir..."
            textView.textColor = UIColor.lightGray
        }
        //resize textEditor
        let constraint = self.textView.constraints.first(where: {$0.identifier == "textViewHeigh"})
        constraint?.constant = 250
    }
    

    func textViewDidChange(_ textView: UITextView) {
        question?.valuesSelected = [textView.text]
    }
    
    func endEditingTextView(){
        textView.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //500 chars restriction
        return textView.text.count + (text.count - range.length) <= 500
    }
    

    
    
}
