//
//  FPCardCollectionViewLayout.swift
//  FinalProject
//
//  Created by Лада on 27/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class FPCardCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private var numberOfColumns = 0
    private let cellPadding: CGFloat = 1
    
    
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        let cardCount = collectionView!.numberOfItems(inSection: 0)
        
//        !!!!!!!!!! определим количество столбцов !!!! т.к. у нас можно извлечь целый квадратный корень, то ячейки не сместятся, но если играть с количеством, некоторые ячейки могут пропасть из видимого экрана
        numberOfColumns = Int(sqrt(Double(cardCount)))
        // данных в layoutAttributes нет
        guard
            layoutAttributes.isEmpty == true,
            let collectionView = collectionView
            else {
                return
        }
        
        // Задаем значения ширины и отступов
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        // Итеративно идем по всем item'ам collectionView
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let itemHeight = columnWidth
            let height = cellPadding * 2 + itemHeight
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Создаем аттрибуты для указанного indexPath
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            layoutAttributes.append(attributes)
            
            //
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }

    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in layoutAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.item]
    }

}
