//
//  BreedListVC.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 21/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import UIKit

class BreedListVC: UIViewController {

    var tableView: UITableView              = UITableView()
    var breedDataSet: [String: [String]]    = Services().fetchListOfBreeds()
    
    lazy var breedList = { () -> [String] in
        // Extract All Breed Names
        var breeds: [String] = []
        for item in self.breedDataSet.keys {
            breeds.append(item)
        }
        
        // Arrange alphabetically
        breeds = breeds.sorted(by: {$0 < $1})
        
        return breeds
    }()
    
    lazy var subBreedList = { (breedName: String) -> [String] in
        var subBreeds: [String] = []
        subBreeds = self.breedDataSet[breedName] ?? [""]
        subBreeds = subBreeds.sorted(by: {$0 < $1})
        return subBreeds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dog Breeds"
        configTableView()
    }
    
    func configTableView() -> Void {
        
        view.addSubview(tableView)
        
        tableView.delegate              = self
        tableView.dataSource            = self
        
        tableView.estimatedRowHeight    = 80
        tableView.rowHeight             = UITableView.automaticDimension
        
        tableView.register(BreedListCell.self, forCellReuseIdentifier: "BreedListCell")
        
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


extension BreedListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: "BreedListCell") as! BreedListCell
        let cellContent = breedList[indexPath.row]
        cell.configCell(content: cellContent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBreed: String   = breedList[indexPath.row]
        let subBreed: [String] = subBreedList(selectedBreed)
        
        if subBreed.isEmpty {
            
            //Navigate to Breed Gallery Screen
            let destination = GalleryVC()
            destination.breedName = selectedBreed
            self.navigationController?.pushViewController(destination, animated: true)
            
        } else {
            
            // Navigate to SubBreed Screen
            let destination             = SubBreedListVC()
            destination.breedName       = selectedBreed
            destination.subBreedList    = subBreed
            self.navigationController?.pushViewController(destination, animated: true)
            
        }
    }
}

