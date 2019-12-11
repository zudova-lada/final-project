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

final class ChooseCollectionViewController: UIViewController, ChooseCollectionInput{
    
    var changeCardCollection: UpdateCardCollection!
    var gameModel: ChooseCollectionOutput!
    
    
    private var cardCollectionView: UICollectionView!
    private let dataSource = ChooseCollectionDataSource()
    private let delegate = ChooseCollectionDelegate()
    private let layout = UICollectionViewFlowLayout()
    
    private let saveMessage = UIAlertController(title: "Save", message: "Идет сохранение изображений в базу данных, пожалуйста, подождите", preferredStyle: .alert)
    
    
    //  Кнопка, по которой задается 16 карточек
    let easyLVLButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(tapEasyButton))
            .set(title: "16")
            .build()
        return button
    }()
    //  Кнопка, по которой задается 36 карточки
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
        
        
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cardCollectionView =  UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height/19*7, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout: layout)
        cardCollectionView.register(ChooseCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        dataSource.cardCollection = gameModel.getDataForView16()
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
        
        dataSource.cardCollection = gameModel.getDataForView16()
        easyLVLButton.backgroundColor = .gray
        hardLVLButton.backgroundColor = .lightGray
        gameModel.changeCollectionForAdding(count:16)
        cardCollectionView.reloadData()
        
    }
    
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        dataSource.cardCollection = gameModel.getDataForView36()
        easyLVLButton.backgroundColor = .lightGray
        hardLVLButton.backgroundColor = .gray
        gameModel.changeCollectionForAdding(count:36)
        cardCollectionView.reloadData()
    }
    
    
    
    @objc private func chooseCollectionButton() {
        
        let centerPoint = CGPoint(x: cardCollectionView.bounds.origin.x + cardCollectionView.bounds.size.width/2, y:  cardCollectionView.bounds.origin.y + cardCollectionView.bounds.size.height/2)
        if let centerIndexPath: IndexPath  = cardCollectionView.indexPathForItem(at: centerPoint) {
            let name = dataSource.cardCollection[centerIndexPath.row].name
            gameModel.loadCollection(nameCollection: name)
        } else {
            errorMessage(error: "ячейка не может быть распознана")
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func addNewCollectionButton() {
        let addNewCollectionController = AddCollectionVIewController()
        addNewCollectionController.cardCount = gameModel.getCollectionForAdding()
        addNewCollectionController.collectionForAdding = self
        navigationController?.pushViewController(addNewCollectionController, animated: true)
    }
    
    func errorMessage(error: String){
        let errorMessage = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        errorMessage.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(errorMessage, animated: true)
    }
    
    //    MARK: -ChooseCollectionInput
    
    func updateDataSource(with model: ImagesModel) {
        self.dataSource.cardCollection.append(model)
        self.cardCollectionView.reloadData()
    }
    
    func loadingCollection() {
        self.present(saveMessage, animated: true)
    }
    func endOfLoading(){
        saveMessage.dismiss(animated: true, completion: nil)
    }
    
    func getCurrentDataCount()->Int {
        return dataSource.cardCollection.count
    }
    
}

extension ChooseCollectionViewController: AddNewCollection {
    
    
    
    //    MARK: -AddNewCollection
    func addCollection(newCollection:[ImageModel]) {
        
        let collectionName = String(dataSource.cardCollection.count) + String(newCollection.count)
        
        gameModel.addCollection(newCollection:newCollection, newCollectionName: collectionName)
        
        
    }
    
}
