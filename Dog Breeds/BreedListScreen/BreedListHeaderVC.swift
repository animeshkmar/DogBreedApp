//
//  BreedListHeaderVC.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 02/05/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

protocol UpdateBreedListDelegate {
    func didFinishSearching()
}

class BreedListHeaderVC: UITableViewHeaderFooterView {

    var header: UISearchBar = UISearchBar()
    
    var updateBreedListDelegate: UpdateBreedListDelegate!
    
    func configHeader() -> Void {
        addSubview(header)
        
        // Set Properties
        header.placeholder = "Search for breeds"
        header.delegate = self
        
        setHeaderConstraints()
    }
    
    func setHeaderConstraints() -> Void {
        header.translatesAutoresizingMaskIntoConstraints                                    = false
        header.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive               = true
        header.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive         = true
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 00).isActive      = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 00).isActive    = true
    }
    
}

extension BreedListHeaderVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        BreedListVC.searchFilter = searchText
        print(BreedListVC.searchFilter)
        updateBreedListDelegate.didFinishSearching()
    }
}
