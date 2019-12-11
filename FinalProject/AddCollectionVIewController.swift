//
//  AddCollectionVIewControllerCollectionViewController.swift
//  FinalProject
//
//  Created by Лада on 06/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

final class AddCollectionVIewController: UIViewController, SelectImage {
    
    var cardCount = 0
    var collectionForAdding:AddNewCollection!
    
    
    private var cardCollection = [ImageModel]()
    private var cardCollectionView: UICollectionView!
    private let dataSource = AddCardDataSource()
    private let delegate = CardCollectionViewDelegate()
    private let layout = CardCollectionViewFlowLayout()
    
    private var selectImages = UIImage()
    private var countComplete = 0
    
    private  let addFromGalereyButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(addFromGalery))
            .set(title: "Галерея")
            .build()
        return button
    }()
    
    private  let addFromNetworkButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(addFromNetwork))
            .set(title: "Сеть")
            .build()
        return button
    }()
    
    private  let addCollectionButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(addCollection))
            .set(title: "Добавить в коллекцию")
            .build()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ImageModel(name: "", image: UIImage())
        cardCollection = Array(repeating: model, count: cardCount/2)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        cardCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), collectionViewLayout: layout)
        cardCollectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        dataSource.cardCollection = cardCollection
        cardCollectionView.dataSource = dataSource
        
        cardCollectionView.frame = CGRect(x: 0, y: 2*(navigationController?.navigationBar.frame.height ?? 0), width: view.frame.width, height:view.frame.width + 6)
        cardCollectionView.backgroundColor = .blue
        
        addFromGalereyButton.frame = CGRect(x: view.frame.width/6, y: view.frame.height/16*13, width: view.frame.width/3, height: 75)
        addFromNetworkButton.frame = CGRect(origin: CGPoint(x: view.frame.width/2, y: view.frame.height/16*13), size: addFromGalereyButton.bounds.size)
        
        addCollectionButton.frame = CGRect(origin: addFromGalereyButton.frame.origin, size: CGSize(width: addFromGalereyButton.bounds.width*2, height: addFromGalereyButton.bounds.height))
        addCollectionButton.alpha = 0
        
        view.backgroundColor = UIColor.red
    }
    //   добавляем наши объекты
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .blue
        view.addSubview(cardCollectionView)
        view.addSubview(addFromGalereyButton)
        view.addSubview(addCollectionButton)
        view.addSubview(addFromNetworkButton)
    }
    
    @objc func addFromGalery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @objc func addFromNetwork() {
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = Interactor(networkService: service)
        let viewController = NetworkViewController(interactor: interactor)
        viewController.addCard = self
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @objc func addCollection() {
        navigationController?.popViewController(animated: true)
        collectionForAdding.addCollection(newCollection: dataSource.cardCollection)
        
    }
    
    
    func selectImage(image: UIImage) {
        
        let model = ImageModel(name: String(countComplete), image: image)
        dataSource.cardCollection[countComplete] = model
        countComplete += 1
        cardCollectionView.reloadData()
        if countComplete*2 == cardCount {
            addFromGalereyButton.alpha = 0
            addFromNetworkButton.alpha = 0
            addCollectionButton.alpha = 1
        }
        
    }
    
}


extension AddCollectionVIewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        if image != nil {
            
            let model = ImageModel(name: String(countComplete), image: image!)
            dataSource.cardCollection[countComplete] = model
            countComplete += 1
            cardCollectionView.reloadData()
            if countComplete*2 == cardCount {
                addFromGalereyButton.alpha = 0
                addFromNetworkButton.alpha = 0
                addCollectionButton.alpha = 1
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


