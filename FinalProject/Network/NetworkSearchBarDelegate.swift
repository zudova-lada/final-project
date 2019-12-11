//
//  NetworkSearchBarDelegate.swift
//  FinalProject
//
//  Created by Лада on 11/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class NetworkSearchBarDelegate: BaseComponent,  UISearchBarDelegate {
    
    private var searchString = String()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        self.perform(#selector(letsSearch), with: nil, afterDelay: 2)
        
    }
    
    @objc private func letsSearch()
    {
        mediator?.notify(sender: self, event: "search")
    }
    
    func getSearchText() -> String {
        return searchString
    }
}
