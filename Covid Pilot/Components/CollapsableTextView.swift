//
//  CollapsableTextView.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class CollapsableTextView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("CollapsableTextView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
