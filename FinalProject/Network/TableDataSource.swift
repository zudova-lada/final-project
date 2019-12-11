//
//  TableDataSource.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class TableDataSource:NSObject, UITableViewDataSource {
    
    var images = [ImageModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellreuseId", for: indexPath) as! TableViewCell
        let model = images[indexPath.row]
        
        cell.imageView?.frame = cell.frame
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.name
        
        
        return cell
    }
    
}

