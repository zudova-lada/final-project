//
//  FPAddCollectionVIewControllerCollectionViewController.swift
//  FinalProject
//
//  Created by Лада on 06/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FPAddCollectionVIewController: UIViewController {

    var cardCount = 0
    var collectionForAdding:AddNewCollection!
    
    
    private var cardCollection = [ImageModel]()
    private var cardCollectionView: UICollectionView!
    private let dataSource = FPAddCardDataSource()
    private let delegate = FPCardCollectionViewDelegate()
    private let layout = FPCardCollectionViewFlowLayout()
    
    private var selectImages = UIImage()
    private var countComplete = 0
    
    private  let addFromGalereyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Галерея", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addFromGalery), for: .touchDown)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private  let addCollectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить в коллекцию", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addCollection), for: .touchDown)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ImageModel(name: "", image: UIImage())
        cardCollection = Array(repeating: model, count: cardCount/2)

        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        cardCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), collectionViewLayout: layout)
        cardCollectionView.register(FPCardCell.self, forCellWithReuseIdentifier: "CardCell")
        dataSource.cardCollection = cardCollection
        cardCollectionView.dataSource = dataSource
//        cardCollectionView.delegate = delegate
//        cardCollectionView.isScrollEnabled = false
        
        cardCollectionView.frame = CGRect(x: 0, y: 2*(navigationController?.navigationBar.frame.height ?? 0), width: view.frame.width, height:view.frame.width + 6)
        cardCollectionView.backgroundColor = .blue
        
        addFromGalereyButton.frame = CGRect(x: view.frame.width/6, y: view.frame.height/16*13, width: 300, height: 75)
        addCollectionButton.frame = addFromGalereyButton.frame
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
    }
    
    @objc func addFromGalery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }

    @objc func addCollection() {
        
        collectionForAdding.addCollection(newCollection: dataSource.cardCollection)
        navigationController?.popViewController(animated: true)
    }
}


extension FPAddCollectionVIewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        if image != nil {

            let model = ImageModel(name: String(countComplete), image: image!)
            dataSource.cardCollection[countComplete] = model
            countComplete += 1
            cardCollectionView.reloadData()
            if countComplete*2 == cardCount {
                addFromGalereyButton.alpha = 0
                addCollectionButton.alpha = 1
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


