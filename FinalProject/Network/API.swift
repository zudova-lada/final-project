//
//  API.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit


final class API: AuthHandlerSupportable {
    
    var handler: HandlerAPI?
    
    private static let apiKey = "eca90a3a9f0c959cb2b2ecdbce8deb7a"
    private static let baseUrl = "https://www.flickr.com/services/rest/"
    
    
    static func searchPath(text: String, extras: String) -> URL {
        guard var components = URLComponents(string: baseUrl) else {
            return URL(string: baseUrl)!
        }
        
        let methodItem = URLQueryItem(name: "method", value: "flickr.photos.search")
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let textItem = URLQueryItem(name: "text", value: text)
        let extrasItem = URLQueryItem(name: "extras", value: extras)
        let formatItem = URLQueryItem(name: "format", value: "json")
        let nojsoncallbackItem = URLQueryItem(name: "nojsoncallback", value: "1")
        
        components.queryItems = [methodItem, apiKeyItem, textItem, extrasItem, formatItem, nojsoncallbackItem]
        
        let request = UrlRequest(baseUrl: "https://www.flickr.com/services/rest/", methodItem: "flickr.photos.search", apiKeyItem: apiKey, formatItem: apiKey, nojsoncallbackItem: "1")
        
        if BaseURLHandler(with: APIItemsHandler()).handle(request) != nil {
            return URL(string: baseUrl)!
        } else {
            return components.url!
        }
        
    }
    
    
}
