//
//  Data.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 02/05/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import Foundation

struct BreedData {
    
    static var breedDataSet: [String: [String]] = Services().fetchListOfBreeds()
    
    
    // Extract Full BreedList
    static var fullBreedList = { (searchText: String) -> [String] in
        
        var breeds: [String] = []
        
        if searchText == "" {
            // Extract All Breed Names
            for item in breedDataSet.keys {
                breeds.append(item)
            }
            // Arrange alphabetically
            breeds = breeds.sorted(by: {$0 < $1})
            return breeds
        }else{
            if let item = breedDataSet.keys.first(where: {$0 == searchText.lowercased()}) {
                breeds.append(item)
                return breeds
            } else {
               return ["No results found"]
            }
        }
    }
    
    
    //Extract Full SubBreed List for a given Breed
    static var fullSubBreedList = { (breedName: String) -> [String] in
        var subBreeds: [String] = []
        subBreeds = breedDataSet[breedName] ?? [""]
        subBreeds = subBreeds.sorted(by: {$0 < $1})
        return subBreeds
    }
    
}
