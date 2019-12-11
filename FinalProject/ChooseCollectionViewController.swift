//
//  ChooseCollectionViewController.swift
//  FinalProject
//
//  Created by Лада on 05/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol AddNewCollection {
    func addCollection(newCollection:[ImageModel])
}

final class ChooseCollectionViewController: UIViewController{
    
    var changeCardCollection: UpdateCardCollection!
    
    private let coreDataManagerCollection = CoreDataManagerCollection()
    private var cardCollectionView: UICollectionView!
    private let dataSource = ChooseCollectionDataSource()
    private let delegate = ChooseCollectionDelegate()
    private let layout = UICollectionViewFlowLayout()
    private var dataForView16 = [ImagesModel]()
    private var dataForView36 = [ImagesModel]()
    private let namesCollections = CoreDataManagerNames()
    private var cardCount = 16
    
    //  Кнопка, по которой задается 16 карточек
    let easyLVLButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(tapEasyButton))
            .set(title: "16")
            .build()
        return button
    }()
    //  Кнопка, по которой задается 32 карточки
    let hardLVLButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(tapHardButton))
            .set(title: "36")
            .build()
        return button
    }()
    
    let chooseButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(chooseCollectionButton))
            .set(title: "Выбрать")
            .build()
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
        
        namesCollections.createPersistentContainer()
        dataForView16 = namesCollections.fetchData16()
        //        namesCollections.deleteAllElements()
        DispatchQueue.global().async {
            self.dataForView36 = self.namesCollections.fetchData36()
        }
        coreDataManagerCollection.createPersistentContainer()
        //        CoreDataManagerCollection.deleteAllElements()
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cardCollectionView =  UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height/19*7, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout: layout)
        cardCollectionView.register(ChooseCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
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
        easyLVLButton.backgroundColor = .gray
        hardLVLButton.backgroundColor = .lightGray
        cardCollectionView.reloadData()
        
    }
    
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        cardCount = 36
        dataSource.cardCollection = dataForView36
        easyLVLButton.backgroundColor = .lightGray
        hardLVLButton.backgroundColor = .gray
        cardCollectionView.reloadData()
    }
    
    
    
    @objc private func chooseCollectionButton() {
        
        let centerPoint = CGPoint(x: cardCollectionView.bounds.origin.x + cardCollectionView.bounds.size.width/2, y:  cardCollectionView.bounds.origin.y + cardCollectionView.bounds.size.height/2)
        if let centerIndexPath: IndexPath  = cardCollectionView.indexPathForItem(at: centerPoint) {
            let name = dataSource.cardCollection[centerIndexPath.row].name
            DispatchQueue.global().async {
                let data = self.coreDataManagerCollection.fetchData(nameCollection: name, collectionCount: self.cardCount)
                
                DispatchQueue.main.async {
                    self.changeCardCollection.udpateCardCollection(newCardCollection: data)
                }
            }
        } else {
            print("ячейка не может быть распознана")
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func addNewCollectionButton() {
        let addNewCollectionController = AddCollectionVIewController()
        addNewCollectionController.cardCount = cardCount
        addNewCollectionController.collectionForAdding = self
        navigationController?.pushViewController(addNewCollectionController, animated: true)
    }
    
}

extension ChooseCollectionViewController: AddNewCollection {
    
    //    MARK: -AddNewCollection
    func addCollection(newCollection:[ImageModel]) {
        
        let collectionName = String(dataSource.cardCollection.count) + String(newCollection.count)
        var images = [UIImage]()
        
        for i in 0..<4 {
            images.append(newCollection[i].image)
        }
        
        let model = ImagesModel(name: collectionName, images: images)
        
        self.dataSource.cardCollection.append(model)
        self.cardCollectionView.reloadData()
        
        switch newCollection.count {
        case 8:
            dataForView16.append(model)
        case 18:
            dataForView36.append(model)
        default: do {}
        }
        
        DispatchQueue.global().async {
            let savingName = CollectionHelper(context: self.namesCollections.context)
            savingName.collectionName = collectionName
            savingName.image1 = NSData(data: images[0].pngData()!) as NSData
            savingName.image2 = NSData(data: images[1].pngData()!) as NSData
            savingName.image3 = NSData(data: images[2].pngData()!) as NSData
            savingName.image4 = NSData(data: images[3].pngData()!) as NSData
            savingName.count = String(newCollection.count)
            
            self.namesCollections.saveContext()
            
        }
        
        let saveMessage = UIAlertController(title: "Save", message: "Идет сохранение изображений в базу данных, пожалуйста, подождите", preferredStyle: .alert)
        self.present(saveMessage, animated: true)
        
        DispatchQueue.global().async {
            self.coreDataManagerCollection.saveContext(imageCollection: newCollection, collectionName: collectionName) { result in
                if result {
                    saveMessage.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
}
