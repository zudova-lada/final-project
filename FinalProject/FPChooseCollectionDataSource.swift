//
//  FPChooseCollectionDataSource.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class FPChooseCollectionDataSource: NSObject, UICollectionViewDataSource {

    var cardCollection: [[ImageModel]]!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! FPChooseCollectionViewCell
        
        let imageModel = cardCollection[indexPath.row]

        cell.cardImageView1.image = imageModel.randomElement()?.image
        cell.cardImageView2.image = imageModel.randomElement()?.image
        cell.cardImageView3.image = imageModel.randomElement()?.image
        cell.cardShirtImageView.image = imageModel.randomElement()?.image
        
        return cell
    }
}
