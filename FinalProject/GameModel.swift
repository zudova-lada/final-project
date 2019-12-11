//
//  GameMenuModel.swift
//  FinalProject
//
//  Created by Лада on 11/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol GameModelOutput {
    func getCardCollection(cardCount: Int) -> [ImageModel]
    func makeBaseCollection(cardCount: Int) -> [ImageModel]
}

protocol MainMenuOutput {
    func changeCardCount(cardCount: Int)
    func currectCardCount()->Int
    func giveCurrentCollectionImage()->UIImage
    func giveCurrentCardCollection() -> [ImageModel]
}

protocol ChooseCollectionOutput {
    func getDataForView16() -> [ImagesModel]
    func getDataForView36() -> [ImagesModel]
    func loadCollection(nameCollection: String)
    func currectCardCount()->Int
    func addCollection(newCollection:[ImageModel], newCollectionName: String)
    func changeCollectionForAdding(count: Int)
    func getCollectionForAdding() -> Int
}

protocol AddNewCollectionOutput {
    func currectCardCount()->Int
}

protocol ChooseCollectionInput {
    func updateDataSource(with model: ImagesModel)
    func loadingCollection()
    func endOfLoading()
    func getCurrentDataCount()->Int
}



class GameModel: MainMenuOutput, ChooseCollectionOutput, AddNewCollectionOutput{
    
    var mainMenu: MainMenuInput!
    var chooseCollection: ChooseCollectionInput!
    
    private var cardCollection16: [ImageModel] = []
    private var cardCollection36: [ImageModel] = []
    private var currentCardCollection: [ImageModel] = []
    private var cardCount: Int = 0
    
    private var dataForView16 = [ImagesModel]()
    private var dataForView36 = [ImagesModel]()
    private let namesCollections = CoreDataManagerNames()
    private let coreDataManagerCollection = CoreDataManagerCollection()
    private var collectionForAdding = 16
    
    
    init() {
        cardCount = 16
        for i in 0..<8 {
            let image = UIImage(named: String(i))
            let imageModel = ImageModel(name: String(i), image: image!)
            cardCollection16.append(imageModel)
            cardCollection16.append(imageModel)
        }
        
        for i in 0..<18 {
            let image = UIImage(named: String(i))
            let imageModel = ImageModel(name: String(i), image: image!)
            cardCollection36.append(imageModel)
            cardCollection36.append(imageModel)
        }
        currentCardCollection = cardCollection16
        
        namesCollections.createPersistentContainer()
        coreDataManagerCollection.createPersistentContainer()
        
        DispatchQueue.global().async {
            self.dataForView16 = self.namesCollections.fetchData16()
            self.dataForView36 = self.namesCollections.fetchData36()
            
        }
        
    }
    
    
    //    MARK: - MainMenuOutput
    
    func giveCurrentCollectionImage()->UIImage{
        return currentCardCollection[0].image
    }
    
    func currectCardCount()->Int{
        return cardCount
    }
    
    func changeCardCount(cardCount: Int) {
        switch cardCount {
        case 16:
            currentCardCollection = cardCollection16
        case 36:
            currentCardCollection = cardCollection36
        default:
            mainMenu.errorMessage(errorMessage: "Ошибка в количестве картинок")
        }
        self.cardCount = cardCount
    }
    
    func giveCurrentCardCollection() -> [ImageModel] {
        return currentCardCollection
    }
    
    
    // MARK: -ChooseCollectionOutput
    func getDataForView16() -> [ImagesModel]{
        return dataForView16
    }
    func getDataForView36() -> [ImagesModel]{
        return dataForView36
    }
    
    func loadCollection(nameCollection: String) {
        DispatchQueue.global().async {
            let data = self.coreDataManagerCollection.fetchData(nameCollection: nameCollection, collectionCount: self.cardCount)
            
            DispatchQueue.main.async {
                
                var newCollection = [ImageModel]()
                
                for i in 0..<data.count {
                    newCollection.append(data[i])
                    newCollection.append(data[i])
                }
                
                self.cardCount = newCollection.count
                
                switch self.cardCount {
                case 16:
                    self.cardCollection16 = newCollection
                case 36:
                    self.cardCollection36 = newCollection
                default:
                    self.mainMenu.errorMessage(errorMessage: "Ошибка в количестве картинок")
                }
                
                
                self.changeCardCount(cardCount: newCollection.count)
                
            }
        }
    }
    
    func changeCollectionForAdding(count: Int) {
        collectionForAdding = count
    }
    
    func getCollectionForAdding() -> Int {
        return collectionForAdding
    }
    
    //    MARK: -AddNewCollectionOutput
    
    func addCollection(newCollection:[ImageModel], newCollectionName: String) {
        
        var images = [UIImage]()
        
        for i in 0..<4 {
            images.append(newCollection[i].image)
        }
        
        let model = ImagesModel(name: newCollectionName, images: images)
        
        chooseCollection.updateDataSource(with: model)
        
        switch newCollection.count {
        case 8:
            dataForView16.append(model)
        case 18:
            dataForView36.append(model)
        default: do {}
        }
        
        chooseCollection.loadingCollection()
        
        DispatchQueue.global().async {
            print("hello")
            let savingName = CollectionHelper(context: self.namesCollections.context)
            savingName.collectionName = newCollectionName
            savingName.image1 = NSData(data: images[0].pngData()!) as NSData
            savingName.image2 = NSData(data: images[1].pngData()!) as NSData
            savingName.image3 = NSData(data: images[2].pngData()!) as NSData
            savingName.image4 = NSData(data: images[3].pngData()!) as NSData
            savingName.count = String(newCollection.count)
            
            self.namesCollections.saveContext()
            
        }
        
        
        
        
        DispatchQueue.global().async {
            self.coreDataManagerCollection.saveContext(imageCollection: newCollection, collectionName: newCollectionName) { result in
                if result {
                    self.chooseCollection.endOfLoading()
                }
            }
            
        }
        
    }
    
    
    
    
}
