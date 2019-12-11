//
//  ChooseCollectionDataSource.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class ChooseCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var cardCollection: [ImagesModel]!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! ChooseCollectionViewCell
        
        let imageModel = cardCollection[indexPath.row]
        
        cell.cardImageView1.image = imageModel.images[0]
        cell.cardImageView2.image = imageModel.images[1]
        cell.cardImageView3.image = imageModel.images[2]
        cell.cardShirtImageView.image = imageModel.images[3]
        
        return cell
    }
}
