//
//  FPChooseCollectionViewController.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol AddNewCollection {
    func addCollection(newCollection:[ImageModel])
}


//coreData сюда необходимо подгружать!!!!!!!!

class FPChooseCollectionViewController: UIViewController, AddNewCollection {
    
    var changeCardCollection: UpdateCardCollection!
    
    private let coreDataManager = FPCoreDataManager()
    private var cardCollectionView: UICollectionView!
    private let dataSource = FPChooseCollectionDataSource()
    private let delegate = FPChooseCollectionDelegate()
    private let layout = UICollectionViewFlowLayout()
    private var dataForView16 = [CollectionHelper]()
    private var dataForView36 = [CollectionHelper]()
    
    let namesCollections = FPCoreDataNames()
    
    
//    private var cardCollection16:[[ImageModel]] = []
//    private var cardCollectionData: [[ImageStructure]] = []
    private var cardCount = 16
    
    //  Кнопка, по которой задается 16 карточек
    let easyLVLButton: UIButton = {
        let button = UIButton()
        button.setTitle("16", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapEasyButton), for: .touchDown)
        button.backgroundColor = .lightGray
        button.alpha = 0.85
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    //  Кнопка, по которой задается 32 карточки
    let hardLVLButton: UIButton = {
        let button = UIButton()
        button.setTitle("36", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapHardButton), for: .touchDown)
        button.backgroundColor = .lightGray
        button.alpha = 0.85
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    let chooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(chooseCollectionButton), for: .touchDown)
        button.backgroundColor = .lightGray
        button.alpha = 0.85
        button.layer.borderColor = UIColor.gray.cgColor
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
//        makeCardCollection()
        
        namesCollections.createPersistentContainer()
        dataForView16 = namesCollections.fetchData16()
//        namesCollections.deleteAllElements()
    
        
        DispatchQueue.global().async {
            self.dataForView16 = self.namesCollections.fetchData36()
        }
        coreDataManager.createPersistentContainer()

//        coreDataManager.deleteAllElements()
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cardCollectionView =  UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height/19*7, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout: layout)
        cardCollectionView.register(FPChooseCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        dataSource.cardCollection = dataForView16
        cardCollectionView.dataSource = dataSource
        cardCollectionView.delegate = delegate
        cardCollectionView.isPagingEnabled = false
        cardCollectionView.isScrollEnabled = true
        cardCollectionView.backgroundColor = .clear
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCollectionButton))
        
        easyLVLButton.backgroundColor = .gray
        easyLVLButton.frame = CGRect(x: width/12, y: height/9*2, width: width/3, height: height/12)
        hardLVLButton.frame = CGRect(x: width/12*7, y: height/9*2, width: width/3, height: height/12)
        chooseButton.frame = CGRect(x: width/4, y: height/9*7, width: width/2, height: height/12)
        text.frame = CGRect(origin:.zero, size: CGSize(width: width/2, height: height/12))
        text.center = CGPoint(x: width/2, y: height/7)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor.cyan
        view.addSubview(cardCollectionView)
        view.addSubview(easyLVLButton)
        view.addSubview(hardLVLButton)
        view.addSubview(chooseButton)
        view.addSubview(text)
    }
    
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapEasyButton() {

        cardCount = 16
        dataSource.cardCollection = dataForView16
        cardCollectionView.reloadData()

    }
    
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        cardCount = 36
        dataSource.cardCollection = dataForView36
        cardCollectionView.reloadData()
    }
    
    
    
//    подправить под красивую логику
//    !!!!!!!!!
//    !!!!!!!!!!
//    !!!!!!!
    @objc private func chooseCollectionButton() {

        let centerPoint = CGPoint(x: cardCollectionView.bounds.origin.x + cardCollectionView.bounds.size.width/2, y:  cardCollectionView.bounds.origin.y + cardCollectionView.bounds.size.height/2)
        if let centerIndexPath: IndexPath  = cardCollectionView.indexPathForItem(at: centerPoint) {
            let name = dataSource.cardCollection[centerIndexPath.row].collectionName
            DispatchQueue.global().async {
                let data = self.coreDataManager.fetchData(nameCollection: name, collectionCount: self.cardCount)
                
                DispatchQueue.main.async {
                    self.changeCardCollection.udpateCardCollection(newCardCollection: data)
                }
            }
        } else {
            print("ячейка не может быть распознана")
        }
        
        navigationController?.popViewController(animated: true)
        
    }

    @objc func addNewCollectionButton() {
        let addNewCollectionController = FPAddCollectionVIewController()
        addNewCollectionController.cardCount = cardCount
        addNewCollectionController.collectionForAdding = self
        navigationController?.pushViewController(addNewCollectionController, animated: true)
    }
    
    func addCollection(newCollection:[ImageModel]) {

            let collectionName = dataSource.cardCollection.count
        
        DispatchQueue.main.async {
            var images = [Data?]()
            
            for i in 0..<4 {
                images.append(newCollection[i].image.pngData())
            }
            
            let savingName = CollectionHelper(context: self.namesCollections.context)
            savingName.collectionName = String(collectionName)
            savingName.image1 = NSData(data: images[0]!) as NSData
            savingName.image2 = NSData(data: images[1]!) as NSData
            savingName.image3 = NSData(data: images[2]!) as NSData
            savingName.image4 = NSData(data: images[3]!) as NSData
            savingName.count = Int16(newCollection.count)
            
            self.dataSource.cardCollection.append(savingName)
            self.namesCollections.saveContext()
            
            self.cardCollectionView.reloadData()
        }
        
        DispatchQueue.global().async {
//            вот тут может быть ай-ай-ай
            self.coreDataManager.saveContext(imageCollection: newCollection, collectionName: String(collectionName))
       
        }
    

        
    }
    
//    func makeCardCollection(){
//
//        let firstCardCount = Int(cardCount/2)
//        var newCardCollection = [ImageModel]()
//        for i in 0..<firstCardCount {
//            let name = String(i)
//            let card = ImageModel(name: name, image: UIImage(named: name)!)
//            newCardCollection.append(card)
//        }
//
//        cardCollection16.append(newCardCollection)
//    }
}
