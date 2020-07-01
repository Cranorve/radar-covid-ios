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
    func showLoading() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light )
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 99
        DispatchQueue.main.async { [weak self] in
            blurEffectView.fadeIn()
            self?.addSubview(blurEffectView)
        }
        
        let loader = NVActivityIndicatorView(frame: CGRect(x: self.center.x-65, y: self.center.y-65, width: 130, height: 130), type: NVActivityIndicatorType.ballScaleMultiple, color: UIColor.twilight )
            DispatchQueue.main.async { [weak self] in
                loader.startAnimating()
                self?.addSubview(loader)
            }
        
    }
    func hideLoading(){
        DispatchQueue.main.async { [weak self] in
            for view in self?.subviews ?? [] {
                if view is NVActivityIndicatorView || view.tag == 99{
                    view.removeFromSuperview()
                }
            }
        }
    }
    func fadeIn(){
        self.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    
    func fadeOut(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
