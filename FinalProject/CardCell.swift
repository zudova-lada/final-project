//
//  CardCell.swift
//  FinalProject
//
//  Created by Лада on 27/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

final class CardCell: UICollectionViewCell {
    
    
    //    создано для тестирования, чтобы не искать одинаковые карточки
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let cardImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        return image
    }()
    
    var cardShit:UIImage = UIImage()
    var cardImage:UIImage = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.backgroundColor = .yellow
        contentView.addSubview(cardImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotationCard(){
        let changeImage = cardImage
        cardImage = cardShit
        cardShit = changeImage
        cardImageView.image = changeImage
    }
    
    override func prepareForReuse() {
        textLabel.text = ""
        cardShit = UIImage()
        cardImage = UIImage()
        cardImageView.image = UIImage()
        
    }
    
}
