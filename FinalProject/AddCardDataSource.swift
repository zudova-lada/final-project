//
//  AddCardDataSource.swift
//  FinalProject
//
//  Created by Лада on 06/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class AddCardDataSource: NSObject, UICollectionViewDataSource {
    
    var cardCollection: [ImageModel]!
    var collectionCount = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.cardImageView.image = cardCollection[indexPath.row].image
        //        cell.textLabel.text = cardCollection[indexPath.row].name
        if cardCollection[indexPath.row].name == ""{
            cell.backgroundColor = .clear
            cell.cardImageView.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
        } else {
            cell.contentView.backgroundColor = .yellow
        }
        return cell
    }
    
}
