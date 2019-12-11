//
//  TableViewCell.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.textLabel?.text = ""
        self.imageView?.image = nil
    }
}
