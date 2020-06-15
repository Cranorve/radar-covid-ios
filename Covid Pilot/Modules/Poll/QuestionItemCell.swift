//
//  QuestionItemCell.swift
//  Covid Pilot
//
//  Created by alopezh on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class QuestionItemCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var checkImage: UIImageView!
    
    var questionOption: QuestionOption? {
        didSet {
            titleLabel.text = questionOption?.option
            checkState()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8;
        layer.masksToBounds = true;
        // Initialization code
    }
    
    func toggleSelected() {
        questionOption?.selected = !(questionOption?.selected ?? false)
        checkState()
    }
    
    private func checkState() {
        checkImage.isHidden = !(questionOption?.selected ?? false)
    }
    

}
