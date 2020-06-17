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

            }).disposed(by: disposeBag)
        }
    }
    
    var router: AppRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func navigateIf(reported: Bool) {
        if (reported){
            router?.route(to: Routes.MyHealthReported, from: self)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
