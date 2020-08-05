//
//  HighExpositionViewController+CASelectorExtension.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 30/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

extension HighExpositionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setCaSelector(){
        self.selectorView.image = UIImage.init(named: "WhiteCard")
        self.selectorView.isUserInteractionEnabled = true
        self.ccaUseCase.getCCAA().subscribe(onNext: { (data) in
            self.ccaArray = data
        }, onError: { (err) in
            print(err)
            self.ccaArray = []
        })
        guard let currentCa = self.ccaUseCase.getCurrent() else {
            self.phoneView.isHidden = true
            self.phoneViewHiddenConstraint.priority = .defaultHigh
            self.phoneViewVisibleConstraint.priority = .defaultLow
            return
        }
        
        self.phoneViewHiddenConstraint.priority = .defaultLow
        self.phoneViewVisibleConstraint.priority = .defaultHigh
        self.phoneView.isHidden = false
        self.phoneLabel.text = currentCa.phone ?? "CONTACT_PHONE".localized
        self.covidWeb.text = currentCa.web ?? ""
        self.caSelectorButton.setTitle(currentCa.description ?? "Seleccione su comunidad autónoma", for: .normal)
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
        self.setCaSelector()
    }
    
    
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
        guard let currentCa =  self.ccaArray?[row] ?? self.ccaArray?.first else {
            return
        }
        ccaUseCase.setCurrent(ca: currentCa)
        
    }
    
}
