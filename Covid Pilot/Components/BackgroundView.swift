//
//  GradientView.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView : UIView {

    private var gradient : CAGradientLayer?
    private var imageView: UIImageView?

    var colors: [CGColor]? {
        didSet {
            gradient = CAGradientLayer()
            gradient!.colors = colors
        }
    }
    
    var image: UIImage? {
        didSet {
            if let imageView = imageView {
                imageView.removeFromSuperview()
            }
            imageView = UIImageView(frame: self.bounds)
            imageView!.image = image
            draw(self.bounds)
        }
    }
    
    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient?.frame = self.bounds
        imageView?.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        if let gradient = gradient {
            gradient.frame = self.bounds
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            if gradient.superlayer == nil {
                layer.insertSublayer(gradient, at: 0)
            }
        }
        
        if let imageView = imageView {
            addSubview(imageView)
            sendSubviewToBack(imageView)
            imageView.frame = self.bounds
        }

    }
    
}
