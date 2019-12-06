//
//  FPChooseCollectionViewCell.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class FPChooseCollectionViewCell: UICollectionViewCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let cardImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage()
        return imageView
    }()
    let cardImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.image = UIImage()
        return imageView
    }()
    let cardImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.image = UIImage()
        return imageView
    }()
    let cardShirtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage()
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let height = frame.height
        let width = frame.width
        let imageSize = CGSize(width: width/3, height: height/3)
        
    
        cardImageView1.frame = CGRect(origin: CGPoint(x: width/12*1, y: height/6), size: imageSize)
        cardImageView2.frame = CGRect(origin: CGPoint(x: width/12*3, y: height/6), size: imageSize)
        cardImageView3.frame = CGRect(origin: CGPoint(x: width/12*5, y: height/6), size: imageSize)
        cardShirtImageView.frame = CGRect(origin: CGPoint(x: width/12*7, y: height/6), size: imageSize)
        
        
        contentView.backgroundColor = .white
        contentView.addSubview(cardShirtImageView)
        contentView.addSubview(cardImageView3)
        contentView.addSubview(cardImageView2)
        contentView.addSubview(cardImageView1)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
