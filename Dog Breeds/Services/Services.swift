//
//  Services.swift
//  Dog Breeds
//
//  Created by Animesh Kumar on 21/04/20.
//  Copyright © 2020 Animesh K. All rights reserved.
//

import Foundation

class Services {
    
    // Get Request To Fetch List Of All Dog Breeds
    func fetchListOfBreeds() -> [String : [String]] {
        let requestURL      = "https://dog.ceo/api/breeds/list/all"
        
        // Get Response
        let responseData: [String: Any]
        responseData        = getRequest(requestURL: requestURL) as! [String: Any]
        
        // Extract Breed Data Set Out
        let breedDataSet: [String: [String]]
        breedDataSet        = responseData["message"] as! [String : [String]]
        
        return breedDataSet
    }
    
    // Get Request To Fetch Image URL Array For selected Breed
    func fetchBreedImages(breedName: String) -> [String] {
        let requestURL      = "https://dog.ceo/api/breed/\(breedName)/images"
        
        // Get Response
        let responseData: [String: Any]?
        responseData        = getRequest(requestURL: requestURL) as? [String: Any]
        
        // Extract Message
        var arrayOfImages: [String]?
        arrayOfImages       = responseData?["message"] as? [String]
        
        return arrayOfImages ?? ["Something went wrong"]
    }
    
    // Get Request To Fetch Image URL Array For selected Breed
    func fetchSubBreedImages(breedName: String, subBreedName: String) -> [String] {
        let requestURL      = "https://dog.ceo/api/breed/\(breedName)/\(subBreedName)/images"
        
        // Get Response
        let responseData: [String: Any]?
        responseData        = getRequest(requestURL: requestURL) as? [String: Any]
        
        // Extract Message
        var arrayOfImages: [String]?
        arrayOfImages       = responseData?["message"] as? [String]
        
        return arrayOfImages ?? ["Something went wrong"]
    }
}

extension Services {
    
    // GET REQUEST
    func getRequest(requestURL: String) -> Any {
        
        var responseData: Any?
        var fetchComplete: Bool = false
        
        guard let url = URL(string: requestURL) else {return [""]}
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    responseData = json
                }
                catch {
                    print(error)
                }
            }
            fetchComplete = true
        }
        
        session.resume()
        
        while !fetchComplete {}
        
        return responseData as Any
    }
    
}
