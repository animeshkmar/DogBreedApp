//
//  SubBreedListCell.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 22/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class SubBreedListCell: UITableViewCell {

    var label: UILabel = Label(frame: CGRect.zero, content: "")
    
    func configLabel(content: String) -> Void {
        addSubview(label)
        label.text = content
        setLabelConstraints()
    }
    
    func setLabelConstraints() -> Void {
        label.translatesAutoresizingMaskIntoConstraints                                     = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive       = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive    = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive               = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive        = true
    }

}
