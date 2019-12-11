//
//  Interactor.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol InteractorInput {
    func loadImage(at path: String, completion: @escaping (UIImage?) -> Void)
    func loadImageList(by searchString: String, completion: @escaping ([ImageNetworkModel]) -> Void)
}

final class Interactor: InteractorInput {
    let networkService: NetworkServiceInput
    
    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }
    
    
    func loadImage(at path: String, completion: @escaping (UIImage?) -> Void) {
        networkService.getData(at: path, parameters: nil) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
    }
    
    func loadImageList(by searchString: String, completion: @escaping ([ImageNetworkModel]) -> Void) {
        let url = API.searchPath(text: searchString, extras: "url_m")
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion([])
                return
            }
            let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .init()) as? Dictionary<String, Any>
            
            guard let response = responseDictionary,
                let photosDictionary = response["photos"] as? Dictionary<String, Any>,
                let photosArray = photosDictionary["photo"] as? [[String: Any]] else {
                    completion([])
                    return
            }
            
            let models = photosArray.map { (object) -> ImageNetworkModel in
                let urlString = object["url_m"] as? String ?? ""
                let    title = object["title"] as? String ?? ""
                return ImageNetworkModel(path: urlString, description: title)
            }
            completion(models)
        }
    }
}
