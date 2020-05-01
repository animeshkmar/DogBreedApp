//
//  Label.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 21/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    init(frame: CGRect, content: String) {
        super.init(frame: frame)
        configLabel(content: content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLabel(content: String) -> Void {
        text = content
    }
    
}
