//
//  UIViewController+Extension.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func open(phone: String) {
        let url = URL(string:  "tel://\(phone.replacingOccurrences(of: " ", with: ""))")

        if let url = url , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            debugPrint("Cant open dialer: \(String(describing: url?.description))")
        }
    }
    
}
