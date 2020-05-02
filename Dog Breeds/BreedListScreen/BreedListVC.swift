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
    static var searchFilter: String         = ""
    var breedList: [String]                 = BreedData.fullBreedList(BreedListVC.searchFilter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dog Breeds"
        configTableView()
    }
    
    func configTableView() -> Void {
        
        view.addSubview(tableView)
        
        tableView.delegate                      = self
        tableView.dataSource                    = self
        
        tableView.estimatedRowHeight            = 80
        tableView.estimatedSectionHeaderHeight  = 80
        tableView.rowHeight                     = UITableView.automaticDimension
        
        tableView.register(BreedListCell.self, forCellReuseIdentifier: "BreedListCell")
        tableView.register(BreedListHeaderVC.self, forHeaderFooterViewReuseIdentifier: "BreadListHeader")
        
        // Dismiss Search Keyboard When User Continues To Browse List
        tableView.keyboardDismissMode = .onDrag
        
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
    
    // HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BreadListHeader") as! BreedListHeaderVC
        header.updateBreedListDelegate = self
        header.configHeader()
        return header
    }
    
    // CELLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.breedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: "BreedListCell") as! BreedListCell
        let cellContent = self.breedList[indexPath.row]
        cell.configCell(content: cellContent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBreed: String   = self.breedList[indexPath.row]
        let subBreed: [String]      = BreedData.fullSubBreedList(selectedBreed)

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

extension BreedListVC: UpdateBreedListDelegate {
    func didFinishSearching() {
        breedList = BreedData.fullBreedList(BreedListVC.searchFilter)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        print("Done!")
    }
}
