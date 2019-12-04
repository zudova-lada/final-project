//
//  FPCardCollectionViewDelegate.swift
//  FinalProject
//
//  Created by Лада on 27/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

// считаем перевороты карт, если переворотов 2, то если имена карт одинаковые, они исчезают, а игроку добавляется очко и дается право повторного хода, если имена карт разные, то карты переворачиваются обратно, а право хода переходит к следующему игроку
class FPCardCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var gameMenuViewController: UpdateGamePoints!
    private var countRotation = 0
    private var firstRotationPath: IndexPath? = nil
    private var currentGamer = 1
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if firstRotationPath == indexPath {
            return
        }
        
        if countRotation == 0 {
            firstRotationPath = indexPath
        }
        
        countRotation += 1
        let cell = collectionView.cellForItem(at: indexPath) as! FPCardCell
        cell.rotationCard()
        
        
        if  countRotation == 2 {
            let cellTwo = collectionView.cellForItem(at: firstRotationPath!) as! FPCardCell
            
            if cell.textLabel.text == cellTwo.textLabel.text {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                    cell.alpha = 0
                    cellTwo.alpha = 0
                    self.gameMenuViewController.addPointsToGamer(gamerNumber: self.currentGamer)
                }
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                    cell.rotationCard()
                    cellTwo.rotationCard()
                    self.changeGamer()
                }
            }
            
            countRotation = 0
            firstRotationPath = nil
            
            
            
        }
        
    }
    
    func changeGamer() {
        if currentGamer == 1
        {
            
            currentGamer = 2
            
        } else {
            currentGamer = 1
        }
    }
}
