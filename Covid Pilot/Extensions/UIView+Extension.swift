//
//  UIView+Extension.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 28/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func showLoading(){
        DispatchQueue.main.async {
            // MARK: not finished yet
            let activityIndicatorView = NVActivityIndicatorView(frame: self.frame, type: .audioEqualizer, color: UIColor.init(red: 0.138, green: 0.124, blue: 0.183, alpha: 1), padding: 100)
            activityIndicatorView.startAnimating()
        }
    }
}
