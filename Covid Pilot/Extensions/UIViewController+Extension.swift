//
//  UIViewController+Extension.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    func open(phone: String) {
        let url = URL(string:  "tel://\(phone.replacingOccurrences(of: " ", with: ""))")

        if let url = url , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            debugPrint("Cant open dialer: \(String(describing: url?.description))")
        }
    }
    
    func showAlertOk(title: String, message: String, buttonTitle: String, _ callback: ((Any) -> Void)? = nil) {
        
        let uiAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { (alert) in
            self.view.removeTransparentBackGround()
            callback?(alert)
        }
        uiAlert.addAction(action)
        let buttonView = uiAlert.view.subviews.first?.subviews.first?.subviews.first?.subviews[1]
        uiAlert.view.tintColor = UIColor.white
        buttonView?.backgroundColor  = #colorLiteral(red: 0.4550000131, green: 0.5799999833, blue: 0.92900002, alpha: 1)
    
        self.view.showTransparentBackground(withColor: UIColor.blueyGrey90, alpha: 1)
        self.present(uiAlert, animated: true, completion: nil)
    }
    
    func showAlertCancelContinue(title: String, message: String, buttonOkTitle: String, buttonCancelTitle: String,
        okHandler:  ((UIAlertAction) -> Void)? = nil,
        cancelHandler:  ((UIAlertAction) -> Void)? = nil ) {
        
        let uiAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonOkTitle, style: .default) { (action) in
            self.view.removeTransparentBackGround()
            okHandler?(action)
        }
        uiAlert.addAction(action)
        
        let actionCancel = UIAlertAction(title: buttonCancelTitle, style: .default) { (action) in
            self.view.removeTransparentBackGround()
            cancelHandler?(action)
        }
        uiAlert.addAction(actionCancel)
        let buttonView = uiAlert.view.subviews.first?.subviews.first?.subviews.first?.subviews[1]
        uiAlert.view.tintColor = UIColor.white
        buttonView?.backgroundColor  = #colorLiteral(red: 0.4550000131, green: 0.5799999833, blue: 0.92900002, alpha: 1)
           
        self.view.showTransparentBackground(withColor: UIColor.blueyGrey90, alpha: 1)
        self.present(uiAlert, animated: true, completion: nil)

    }
    
    func showAlertCancelContinue(title: String, message: String, buttonOkTitle: String, buttonCancelTitle: String,  okHandler:  ((UIAlertAction) -> Void)? = nil ) {
        showAlertCancelContinue(title: title, message: message, buttonOkTitle: buttonOkTitle, buttonCancelTitle: buttonCancelTitle, okHandler: okHandler, cancelHandler: nil)
    }
    
    @objc func onWebTap(tapGestureRecognizer: UITapGestureRecognizer) {
        onWebTap(tapGestureRecognizer: tapGestureRecognizer, urlString: (tapGestureRecognizer.view as? UILabel)?.text)
    }
    
    @objc func onWebTap(tapGestureRecognizer: UITapGestureRecognizer, urlString: String? = nil) {
        guard var urlString = urlString else {
            return
        }
        
        if !urlString.contains("://") {
            urlString = "https://\(urlString)"
        }
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}
