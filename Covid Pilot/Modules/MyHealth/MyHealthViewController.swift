//
//  MyHealthViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class MyHealthViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var diagnosisCodeUseCase: DiagnosisCodeUseCase?
    
    @IBOutlet var codeChars: [UITextField]!
    @IBOutlet weak var codeTextField: UITextField!
    
    
    @IBAction func onBack(_ sender: Any) {
        let alert = Alert.showAlertCancelContinue(title:  "¿Seguro que no quieres enviar tu diagnóstico?", message: "Por favor, ayúdanos a cuidar a los demas y evitemos que el Covid-19 se propague.", buttonOkTitle: "OK", buttonCancelTitle: "Cancelar") { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }
    
    @IBAction func onReportDiagnosis(_ sender: Any) {
        if let codigoString = codeTextField.text {
            diagnosisCodeUseCase?.sendDiagnosisCode(code: codigoString).subscribe(
                onNext:{ [weak self] reportedCodeBool in
                    self?.navigateIf(reported: reportedCodeBool)
                }, onError: {  [weak self] error in
                    print("Error reporting diagnosis \(error)")
                    self?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error al enviar diagnóstico", buttonTitle: "Ok"), animated: true)

            }).disposed(by: disposeBag)
        }
    }
    
    var router: AppRouter?
    
    override func viewWillAppear(_ animated: Bool) {
        //hide kayboard in case is shown
        self.view.frame.origin.y = 0
        codeTextField.text = ""
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.codeChars.forEach { (char) in
            char.text = "\u{200B}"
            char.layer.borderWidth = 2
//            char.layer.borderColor = UIColor(displayP3Red: 0.240, green: 0.240, blue: 0.240, alpha: 0.240).cgColor
            char.layer.borderColor = UIColor.red.cgColor
//            char.layer.cornerRadius = 2
            char.addTarget(self, action: #selector(MyHealthViewController.textFieldDidChange(_:)), for: .editingChanged)

        }
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        //Add observers to move up/down the main view when the keyboard appears/dissapear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
  
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("textFieldDidChange", textField.tag, textField.text)
        let actualPos = textField.tag
        
        // if the initial value is an empty string do nothing
        if (textField.text == "\u{200B}"){
            return
        }
        
        // detect backspace
        if ( textField.text == "" || textField.text == nil ){
            if  ( actualPos > 0 && actualPos < self.codeChars.count ) {
                let prev = codeChars[actualPos - 1]
                prev.becomeFirstResponder()
                prev.text = "\u{200B}"
           }
        }
        
        // detect new input and pass to the next one
        else if (actualPos < self.codeChars.count) {
            let next = codeChars[actualPos + 1]
            next.becomeFirstResponder();
        }
       
    }
    
    private func navigateIf(reported: Bool) {
        if (reported){
            router?.route(to: Routes.MyHealthReported, from: self)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    

}
