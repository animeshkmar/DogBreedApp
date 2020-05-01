//
//  ImageDetailVC.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 23/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class ImageDetailVC: UIViewController {
    
    var image: Data?    = nil
    
    var scrollView      = UIScrollView()
    var imageView       = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configScrollView()
        configImageView()
    }
    
    func configScrollView() -> Void {
        
        view.addSubview(scrollView)
        
        scrollView.backgroundColor      = .black
        scrollView.delegate             = self
        scrollView.minimumZoomScale     = 1
        scrollView.maximumZoomScale     = 4
        
        scrollView.showsVerticalScrollIndicator     = false
        scrollView.showsHorizontalScrollIndicator   = false
        
        setScrollViewConstraints()
    }
    

    func configImageView() -> Void {
        
        scrollView.addSubview(imageView)
        
        imageView.image = UIImage(data: image!)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        
        setImageViewConstraints()
    }
    
    func setScrollViewConstraints() -> Void {
        scrollView.translatesAutoresizingMaskIntoConstraints                                        = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive      = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive    = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive              = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive        = true
    }
    
    func setImageViewConstraints() -> Void {
        imageView.translatesAutoresizingMaskIntoConstraints                                        = false
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive      = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive    = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive              = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive        = true
        
        imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

}

extension ImageDetailVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            
            if let image = imageView.image {
                let widthRatio      = imageView.frame.width / image.size.width
                let heightRatio     = imageView.frame.width / image.size.height
                
                let ratio           = widthRatio < heightRatio ? widthRatio : heightRatio
                let newWidth        = image.size.width * ratio
                let newHeight       = image.size.height * ratio
                
                let contitionLeft   = newWidth * scrollView.zoomScale > imageView.frame.width
                let left            = 0.5 * (contitionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                
                let conditionTop    = newHeight * scrollView.zoomScale > imageView.frame.height
                let top             = 0.5 * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }else{
                scrollView.contentInset = .zero
            }
            
        }
    }
}
