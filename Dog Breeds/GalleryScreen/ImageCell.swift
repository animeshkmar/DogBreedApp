//
//  ImageCell.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 22/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    
    // Image Data Caching Object
    var dataObject: Data?
    
    func configImageView(imageURL: String) {
        
        addSubview(imageView)
        
        let url = URL(string: imageURL)
        
        // Check if the image data is available in cache - if not send request.
        if dataObject == nil {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
                        self.imageView.clipsToBounds = true
                        self.imageView.image = UIImage(data: data)
                        self.dataObject = data
                    }
                }else{
                    print("No Image found at url : \(url!)")
                }
            }
        }else{
            imageView.image = UIImage(data: dataObject!)
        }
        setImageViewConstraints()
    }
    
    func setImageViewConstraints() -> Void {
        imageView.translatesAutoresizingMaskIntoConstraints                                     = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive        = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive      = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive          = true
    }
    
    
    
}
