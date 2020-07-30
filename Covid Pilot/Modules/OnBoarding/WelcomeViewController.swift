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
        return localesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return localesArray[row].values.first
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let keys = localesArray[row].keys
        localizationRepository.setLocale(keys.first ?? "")
    }
}

class WelcomeViewController: UIViewController {
    
    var router: AppRouter?
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    var localesArray:[[String: String]] = [["es-ES": "Español"], ["en-US": "Ingles (Estados Unidos)"]]
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
        super.viewDidLoad()

    }
    @IBAction func selectLanguage(_ sender: Any) {
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
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}
