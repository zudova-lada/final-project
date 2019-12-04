//
//  FPCardsCollectionView.swift
//  FinalProject
//
//  Created by Лада on 27/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class FPCardsCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var cardCollection: [ImageModel]!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        тасуем наши карточки
        cardCollection = cardCollection.shuffled()
        return cardCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! FPCardCell
        
        cell.cardImage = cardCollection[indexPath.row].image
        cell.textLabel.text = cardCollection[indexPath.row].name
        return cell
    }
    
}
