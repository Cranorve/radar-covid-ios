//
//  Alert.swift
//  Covid Pilot
//
//  Created by alopezh on 11/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

public class Alert {
    class func showAlertOk(title: String, message: String, buttonTitle: String) -> UIAlertController {
        let uiAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil)
        uiAlert.addAction(action)
        let buttonView = uiAlert.view.subviews.first?.subviews.first?.subviews.first?.subviews[1]
        uiAlert.view.tintColor = UIColor.white
        buttonView?.backgroundColor  = #colorLiteral(red: 0.4550000131, green: 0.5799999833, blue: 0.92900002, alpha: 1)
    
        return uiAlert
    }
    
    class func showAlertCancelContinue(title: String, message: String, buttonOkTitle: String, buttonCancelTitle: String,
        okHandler:  ((UIAlertAction) -> Void)? = nil,
        cancelHandler:  ((UIAlertAction) -> Void)? = nil ) -> UIAlertController {
        
        let uiAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               let action = UIAlertAction(title: buttonOkTitle, style: UIAlertAction.Style.default, handler: okHandler)
               uiAlert.addAction(action)
                let actionCancel = UIAlertAction(title: buttonCancelTitle, style: UIAlertAction.Style.default, handler: cancelHandler)
                uiAlert.addAction(actionCancel)
               let buttonView = uiAlert.view.subviews.first?.subviews.first?.subviews.first?.subviews[1]
               uiAlert.view.tintColor = UIColor.white
               buttonView?.backgroundColor  = #colorLiteral(red: 0.4550000131, green: 0.5799999833, blue: 0.92900002, alpha: 1)
           
               return uiAlert
    }
    
    class func showAlertCancelContinue(title: String, message: String, buttonOkTitle: String, buttonCancelTitle: String,  okHandler:  (_ action: UIAlertAction) -> Void ) -> UIAlertController {
        showAlertCancelContinue(title: title, message: message, buttonOkTitle: buttonOkTitle, buttonCancelTitle: buttonCancelTitle, okHandler: okHandler)
    }
    
}
