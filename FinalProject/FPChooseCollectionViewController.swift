//
//  FPChooseCollectionViewController.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

class FPChooseCollectionViewController: UIViewController {
    
    var changeCardCollection: UpdateCardCollection!
    
    private var cardCollectionView: UICollectionView!
    private let dataSource = FPChooseCollectionDataSource()
    private let delegate = FPChooseCollectionDelegate()
    private let layout = UICollectionViewFlowLayout()
    
    private var cardCollection16:[[ImageModel]] = []
    private var cardCount = 16
    
    //  Кнопка, по которой задается 16 карточек
    let easyLVLButton: UIButton = {
        let button = UIButton()
        button.setTitle("16", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapEasyButton), for: .touchDown)
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        return button
    }()
    //  Кнопка, по которой задается 32 карточки
    let hardLVLButton: UIButton = {
        let button = UIButton()
        button.setTitle("36", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapHardButton), for: .touchDown)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        return button
    }()
    
    let chooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(chooseCollectionButton), for: .touchDown)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        return button
    }()
    
    //  текст на экране, призывающий выбрать коллекцию
    let text: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = "Выберите коллекцию"
        text.textAlignment = .center
        text.contentInset = UIEdgeInsets(top: 120, left:0, bottom: 10, right:0)
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .clear
        text.layer.cornerRadius = 15
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        функция, необходимая для настройки приложения,
//        !!!!!!!не забыть удалить
        makeCardCollection()
        
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cardCollectionView =  UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height/19*7, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout: layout)
        cardCollectionView.register(FPChooseCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        dataSource.cardCollection = cardCollection16
        cardCollectionView.dataSource = dataSource
        cardCollectionView.delegate = delegate
        cardCollectionView.isPagingEnabled = false
        cardCollectionView.isScrollEnabled = true
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapEasyButton))
        
        easyLVLButton.frame = CGRect(x: width/12, y: height/9*2, width: width/3, height: height/12)
        hardLVLButton.frame = CGRect(x: width/12*7, y: height/9*2, width: width/3, height: height/12)
        chooseButton.frame = CGRect(x: width/4, y: height/9*7, width: width/2, height: height/12)
        text.frame = CGRect(origin:.zero, size: CGSize(width: width/2, height: height/12))
        text.center = CGPoint(x: width/2, y: height/7)
        view.backgroundColor = UIColor.blue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor.brown
        view.addSubview(cardCollectionView)
        view.addSubview(easyLVLButton)
        view.addSubview(hardLVLButton)
        view.addSubview(chooseButton)
        view.addSubview(text)
    }
    
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapEasyButton() {

        

    }
    
    
//    подправить под красивую логику
    @objc private func chooseCollectionButton() {

        let centerPoint = CGPoint(x: cardCollectionView.bounds.origin.x + cardCollectionView.bounds.size.width/2, y:  cardCollectionView.bounds.origin.y + cardCollectionView.bounds.size.height/2)
        if let centerIndexPath: IndexPath  = cardCollectionView.indexPathForItem(at: centerPoint) {
//            let cell = cardCollectionView.cellForItem(at: centerIndexPath)
            
            changeCardCollection.udpateCardCollection(newCardCollection: cardCollection16[centerIndexPath.row])
        } else {
            print("ячейка не может быть распознана")
        }
        

        
    }
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        
    }
    
    func makeCardCollection(){
        
        let firstCardCount = Int(cardCount/2)
        var newCardCollection = [ImageModel]()
        for i in 0..<firstCardCount {
            let name = String(i)
            let card = ImageModel(name: name, image: UIImage(named: name)!)
            newCardCollection.append(card)
        }
        
        cardCollection16.append(newCardCollection)
    }
}
