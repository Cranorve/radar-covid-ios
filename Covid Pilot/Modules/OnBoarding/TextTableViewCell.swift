//
//  TextTableViewCell.swift
//  Covid Pilot
//
//  Created by alopezh on 22/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    private var content: String?
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel?.text = content
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func set(content: String) {
        self.content = content
        contentLabel?.text = content
    }
    
}
