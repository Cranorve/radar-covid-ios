//
//  TableHeaderView.swift
//  Covid Pilot
//
//  Created by alopezh on 22/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    var section : Int?
    weak var delegate: ExpandDelegate?
    
    var expanded: Bool = false {
        didSet {
            if  (expanded) {
                imageView.image = UIImage(named:"CollapsableOpen")
                
                titleLabel.textColor = UIColor.black
            } else {
                imageView.image = UIImage(named:"CollapsableClosed")
                titleLabel.textColor = #colorLiteral(red: 0.5410000086, green: 0.4860000014, blue: 0.7179999948, alpha: 1)
            }
        }
    }
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    func configureContents() {
        
        isUserInteractionEnabled = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userTap(tapGestureRecognizer:))))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "Muli-Bold",  size: 20.0)
        titleLabel.numberOfLines = 0
        

        tintColor = #colorLiteral(red: 0.9800000191, green: 0.976000011, blue: 0.9689999819, alpha: 1)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    
        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 7),
            imageView.widthAnchor.constraint(equalToConstant: 13),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo:
                   imageView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    @objc func userTap(tapGestureRecognizer: UITapGestureRecognizer) {
        expanded = !expanded
        delegate?.toggle(section: section)
    }
    
}

protocol ExpandDelegate : AnyObject {
    func toggle(section: Int?)
}
