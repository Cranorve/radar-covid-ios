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
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBAction func onBack(_ sender: Any) {
        let alert = Alert.showAlertCancelContinue(title:  "¿Seguro que no quieres enviar tu diagnóstico?", message: "Por favor, ayúdanos a cuidar a los demas y evitemos que el Covid-19 se propague.", buttonTitle: "OK") { (UIAlertAction) in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        //Add observers to move up/down the main view when the keyboard appears/dissapear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
