//
//  TableDelegate.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class TableDelegate:BaseComponent, UITableViewDelegate {
    private var selectImage = UIImage()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        selectImage = cell.imageView!.image!
        mediator?.notify(sender: self, event: "select Image")
    }
    
    func getImage() -> UIImage {
        return selectImage
    }
}
