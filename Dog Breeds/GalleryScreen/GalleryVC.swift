//
//  GalleryVC.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 22/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {
    
    var breedName: String       = ""
    var subBreedName: String    = ""
    
    var services                            = Services()
    lazy var breedImageArray: [String]      = services.fetchBreedImages(breedName: breedName)
    lazy var subBreedImageArray: [String]   = services.fetchSubBreedImages(breedName: breedName, subBreedName: subBreedName)
    
    var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:  UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = subBreedName != "" ? "\(breedName.capitalized) - \(subBreedName.capitalized)" : breedName.capitalized
        setupCollectionView()
    }
    
    func setupCollectionView() -> Void {
        
        view.addSubview(collectionView)
        
        collectionView.delegate     = self
        collectionView.dataSource   = self
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        setCollectionViewConstraints()
        
    }
    
    func setCollectionViewConstraints() -> Void {
        collectionView.translatesAutoresizingMaskIntoConstraints                                         = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive               = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive         = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive       = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive     = true
    }
}

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if subBreedName != "" {
            return subBreedImageArray.count > 15 ? 15 : subBreedImageArray.count
        }else{
            return breedImageArray.count > 15 ? 15 : subBreedImageArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if subBreedName != "" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.backgroundColor = .systemGray
            let image = subBreedImageArray[indexPath.row]
            cell.configImageView(imageURL: image)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.backgroundColor = .systemGray
            let image = breedImageArray[indexPath.row]
            cell.configImageView(imageURL: image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination     = ImageDetailVC()
        let cell            = collectionView.cellForItem(at: indexPath) as! ImageCell
        let image           = cell.dataObject
        destination.image   = image
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension GalleryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width   = (view.frame.size.width - 2) / 3
        let size    = CGSize(width: width, height: width)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
