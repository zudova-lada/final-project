//
//  FPChooseCollectionDelegate.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class FPChooseCollectionDelegate: NSObject, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lengthCell = min(collectionView.frame.width, collectionView.frame.height)
        
        return CGSize(width: lengthCell, height: lengthCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        let lengthCell = min(collectionView.frame.width, collectionView.frame.height)
        let length = (collectionView.frame.width - lengthCell)/2
        return UIEdgeInsets(top: 0.0, left:length , bottom: 0.0, right: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        print("hello")
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      
        let itemWidth = scrollView.contentSize.height
        
        let cellWidthIncludingSpacing = itemWidth + 5
        let offset = scrollView.contentOffset.x
        let index = (offset + scrollView.contentInset.left) / cellWidthIncludingSpacing // Calculate the cell need to be center
        
        if velocity.x > 0 { // Scroll to -->
            targetContentOffset.pointee = CGPoint(x: ceil(index) * cellWidthIncludingSpacing - scrollView.contentInset.right, y: -scrollView.contentInset.top)
        } else if velocity.x < 0 { // Scroll to <---
            targetContentOffset.pointee = CGPoint(x: floor(index) * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        } else if velocity.x == 0 { // No dragging
            targetContentOffset.pointee = CGPoint(x: round(index) * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        }
    }
    
}
