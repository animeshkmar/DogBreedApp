//
//  SubBreedListVC.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 22/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class SubBreedListVC: UIViewController {
    
    var tableView: UITableView  = UITableView()
    var breedName: String       = ""
    var subBreedList: [String]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = breedName.capitalized
        
        configTableView()
    }
    
    func configTableView() -> Void {
        
        view.addSubview(tableView)
        
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(SubBreedListCell.self, forCellReuseIdentifier: "SubBreedListCel")
        
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() -> Void {
        tableView.translatesAutoresizingMaskIntoConstraints                                         = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive               = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive         = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive       = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive     = true
    }
    
}

extension SubBreedListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subBreedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubBreedListCel") as! SubBreedListCell
        let cellContent = subBreedList[indexPath.row].capitalized
        cell.configLabel(content: cellContent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedSubBreed = subBreedList[indexPath.row]
        let destination             = GalleryVC()
        destination.breedName       = breedName
        destination.subBreedName    = selectedSubBreed
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
