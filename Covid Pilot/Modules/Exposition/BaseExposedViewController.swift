//
//  BaseExposedViewController.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 30/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

class BaseExposed: UIViewController {
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var expositionBGView : BackgroundView!
    @IBOutlet weak var selectorView : BackgroundView!

    var ccaUseCase: CCAAUseCase!
    var lastCheck:Date?
    var ccaArray:[CaData]?
    var pickerOpened = false
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/ciudadania.htm") else { return }
        UIApplication.shared.open(url)
    }
    
    override func viewDidLoad() {
        self.selectorView.image = UIImage.init(named: "WhiteCard")
        self.selectorView.isUserInteractionEnabled = true
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
        self.ccaUseCase.getCCAA().subscribe(onNext: { (data) in
            self.ccaArray = data
        }, onError: { (err) in
            print(err)
            self.ccaArray = []
        })
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func caaSelectAction(_ sender: Any) {
        if !pickerOpened {
            pickerOpened = true
            picker = UIPickerView.init()
            picker.delegate = self
            picker.dataSource = self
            picker.backgroundColor = UIColor.white
            picker.setValue(UIColor.black, forKey: "textColor")
            picker.autoresizingMask = .flexibleWidth
            picker.contentMode = .center
            picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(picker)
            
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.barStyle = .default
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
        }
        
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        pickerOpened = false;
    }
    
}

extension BaseExposed: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ccaArray?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ccaArray?[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ccaUseCase.setCurrent(ca: self.ccaArray?[row] ?? self.ccaArray!.first!)
        
    }
}
