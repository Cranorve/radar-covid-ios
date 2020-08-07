//
//  HighExpositionViewController.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 11/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class HighExpositionViewController: BaseExposed, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let disposeBag = DisposeBag()
    
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    
    @IBOutlet weak var podriasestar: UILabel!
    @IBOutlet weak var infectedText: UILabel!
    @IBOutlet weak var phoneView: BackgroundView!
    @IBOutlet weak var timeTableLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var covidWeb: UILabel!
    
    @IBOutlet weak var phoneViewVisibleConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneViewHiddenConstraint: NSLayoutConstraint!
    var since:Date?
    
    @IBOutlet weak var selectorView : BackgroundView!
    @IBOutlet weak var caSelectorButton: UIButton!
    
    private var currentCA: CaData?
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var ccaUseCase: CCAAUseCase!
    var ccaArray:[CaData]?
    var pickerOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfectedText()
        expositionBGView.image = bgImageRed
        phoneView.isUserInteractionEnabled = true
        self.covidWeb.isUserInteractionEnabled = true
        self.covidWeb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapWeb(tapGestureRecognizer:))))
        
        self.phoneLabel.isUserInteractionEnabled = true
        self.phoneLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))
        phoneView.image = UIImage(named: "WhiteCard")
        
        self.setCaSelector()
        
        caSelectorButton.setTitle("LOCALE_SELECTION_REGION_DEFAULT".localized, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currentCA = ccaUseCase.getCurrent()
    }
    
    @objc func userDidTapWeb(tapGestureRecognizer: UITapGestureRecognizer) {
        onWebTap(tapGestureRecognizer: tapGestureRecognizer, urlString: currentCA?.web)
    }
    
    func setInfectedText() {
        let date = self.since ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let actualizado = formatter.string(from: date)
        var daysSinceLastInfection = Date().days(sinceDate: since ?? Date()) ?? 1
        if daysSinceLastInfection == 0 {
            daysSinceLastInfection = 1
        }
        podriasestar.attributedText = "EXPOSITION_HIGH_DESCRIPTION".localizedAttributed(withParams: [String(daysSinceLastInfection), actualizado])
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: "CONTACT_PHONE".localized)
    }
    
    @objc override func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        onWebTap(tapGestureRecognizer: tapGestureRecognizer, urlString: "EXPOSURE_HIGH_INFO_URL".localized)
    }
    
    func setCaSelector() {
        self.selectorView.image = UIImage.init(named: "WhiteCard")
        self.selectorView.isUserInteractionEnabled = true
        
        self.ccaUseCase.getCCAA().subscribe(onNext: { (data) in
            self.ccaArray = data
        }, onError: { (err) in
            print(err)
            self.ccaArray = []
        }).disposed(by: disposeBag)
        
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
        self.covidWeb.text = currentCa.webName ?? currentCa.web ?? ""
        let title = currentCa.description ?? "LOCALE_SELECTION_REGION_DEFAULT".localized
        self.caSelectorButton.setTitle(title, for: .normal)
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
            toolBar.items = [UIBarButtonItem.init(title: "SELECTOR_DONE".localized, style: .done, target: self, action: #selector(onDoneButtonTapped))]
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
        self.currentCA = currentCa
    }
    
    
}
