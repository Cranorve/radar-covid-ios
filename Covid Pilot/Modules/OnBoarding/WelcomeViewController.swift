//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

extension WelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return localesArray.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return localesArray[ Array(self.localesArray.keys)[row] ] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let key = Array(self.localesArray.keys)[row]
        self.languageSelector.setTitle(self.localesArray[key, default: ""], for: .normal)

        localizationRepository.setLocale(key)
    }
}

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var languageSelector: UIButton!
    var router: AppRouter?
    var pickerOpened = false;
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    var localesArray:[String: String?]!
    var localizationRepository: LocalizationRepository!
    @IBOutlet weak var stepbullet1: UILabel!
    @IBOutlet weak var selectorView: BackgroundView!

    @IBOutlet weak var stepbullet2: UILabel!
    
    @IBOutlet weak var stepbullet3: UILabel!
    @IBAction func onContinue(_ sender: Any) {
        router?.route(to: .OnBoarding, from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectorView.image = UIImage.init(named: "WhiteCard")
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        self.localesArray = self.localizationRepository.getLocales()
        guard let currentLanguage = self.localizationRepository.getLocale() else {
            return
        }
        localizationRepository.setLocale(currentLanguage)
        self.languageSelector.setTitle(self.localesArray[currentLanguage, default: ""], for: .normal)
        super.viewDidLoad()

    }
    @IBAction func selectLanguage(_ sender: Any) {
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
        self.pickerOpened = false
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}
