//
//  CardsCollectionView.swift
//  FinalProject
//
//  Created by Лада on 27/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class CardsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var cardCollection: [ImageModel]!
    var collectionCount = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardCollection = cardCollection.shuffled()
        return cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.cardImage = cardCollection[indexPath.row].image
        cell.textLabel.text = cardCollection[indexPath.row].name
        return cell
    }
    
}
