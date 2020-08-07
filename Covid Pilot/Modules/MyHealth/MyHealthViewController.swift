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
    
    
    @IBOutlet weak var scrollViewBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainer: UIView!

    var diagnosisCodeUseCase: DiagnosisCodeUseCase?
    var statusBar: UIView?
    @IBOutlet var codeChars: [UITextField]!
    @IBOutlet weak var sendDiagnosticButton: UIButton!
    var router: AppRouter?
    
    @IBAction func onBack(_ sender: Any) {
        self.showAlertCancelContinue(title:  "ALERT_MY_HEALTH_SEND_TITLE".localizedAttributed.string, message: "ALERT_MY_HEALTH_SEND_CONTENT".localizedAttributed.string, buttonOkTitle: "ALERT_OK_BUTTON".localizedAttributed.string, buttonCancelTitle: "ALERT_CANCEL_BUTTON".localizedAttributed.string, okHandler: { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
        }, cancelHandler: { (UIAlertAction) in
              
        })
        endEditingCodeChars()
    }
    
    func endEditingCodeChars(){
        for item in codeChars {
            item.endEditing(true)
        }
    }

    @IBAction func onReportDiagnosis(_ sender: Any) {

        view.showLoading()
        var codigoString = ""
        codeChars.forEach {
            let s: String = $0.text ?? ""
            codigoString += s
        }

        diagnosisCodeUseCase?.sendDiagnosisCode(code: codigoString).subscribe(
            onNext:{ [weak self] reportedCodeBool in
                self?.view.hideLoading()
                self?.navigateIf(reported: reportedCodeBool)
            }, onError: {  [weak self] error in
                self?.handle(error: error)
                
                self?.view.hideLoading()

        }).disposed(by: disposeBag)
        
    }
    
    private func handle(error: Error) {
        debugPrint("Error sending diagnosis \(error)")
        var errorMessage = "ALERT_MY_HEALTH_CODE_VALIDATION_CONTENT".localized
        if let diagnosisError = error as? DiagnosisError {
            switch diagnosisError {
            case .ApiRejected:
                errorMessage = "ALERT_SHARING_REJECTED_ERROR".localized
            case .IdAlreadyUsed:
                errorMessage = "ALERT_ID_ALREADY_USED".localized
            case .WrongId:
                errorMessage = "ALERT_WRONG_ID".localized
            default:
                break
            }
        }
        showAlertOk(title: "ALERT_MY_HEALTH_CODE_ERROR_CONTENT".localized, message: errorMessage, buttonTitle: "ALERT_OK_BUTTON".localized)
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        self.codeChars.forEach { (char) in
            char.text = "\u{200B}"
            char.layer.cornerRadius = 5
            char.addTarget(self, action: #selector(MyHealthViewController.textFieldDidChange(_:)), for: .editingChanged)
            

        }
        super.viewWillAppear(true)
        
        sendDiagnosticButton.isEnabled = checkSendEnabled()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        //Add observers to move up/down the main view when the keyboard appears/dissapear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        sendDiagnosticButton.setTitle("MY_HEALTH_DIAGNOSTIC_CODE_SEND_BUTTON".localized, for: .normal)

    }
  
    @objc func textFieldDidChange(_ textField: UITextField) {
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
                textField.text = "\u{200B}"
           }
        }
        
        // detect new input and pass to the next one
        else if (actualPos < self.codeChars.count - 1) {
            // the first character is an unicode empty space so we need to take the second character and assign it to the input
            let finalText = textField.text?.suffix(1)
            textField.text = String(finalText ?? "")
            let next = codeChars[actualPos + 1]
            next.becomeFirstResponder();
        }
        
        // avoid multiple character in the last input
        if (actualPos == self.codeChars.count - 1) {
            let actualText = textField.text ?? "\u{200B}"
            if (actualText != "\u{200B}") {
                let trimmedString = String(actualText.prefix(2))
                let finalString = String(trimmedString.suffix(1))
                textField.text = finalString
            }
        }
       
        sendDiagnosticButton.isEnabled = checkSendEnabled()
    }
    
    private func checkSendEnabled() -> Bool {
        codeChars.filter({ $0.text != "\u{200B}" }).count == codeChars.count
    }
    
    @IBAction func insertCode(_ sender: Any) {
        guard let emptyInput = self.codeChars.filter({ $0.text == "\u{200B}" }).first else {
            self.codeChars.last?.becomeFirstResponder()
            return
        }
        emptyInput.becomeFirstResponder()
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
        DispatchQueue.main.async {
            self.scrollViewBottonConstraint.constant = keyboardSize.height
            self.scrollView.setContentOffset(CGPoint(x: 0, y: keyboardSize.height), animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.scrollViewBottonConstraint.constant = 0
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }


}
