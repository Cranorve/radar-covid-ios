//
//  BaseViewController.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 30/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        listSubviewsOfView(view: self.view)
        super.viewWillAppear(animated)
    }
    
    
    
    func listSubviewsOfView(view: UIView) {
        let labels = view.subviews.compactMap { $0 as? LocalizableLabel }
        for label in labels {
            if (label.locKeyLocalizable != nil) {
                label.updateTexts()

            }
        }
        
        let subviews = view.subviews
        if (subviews.count == 0) { return }
        
        
        for subview in subviews {
         
            self.listSubviewsOfView(view: subview as UIView)
        }
    }
    

}
