//
//  ViewController.swift
//  FinalProject
//
//  Created by Лада on 25/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol UpdateCardCollection {
    func udpateCardCollection(newCardCollection: [ImageModel])
}


//  Главное меню игры, здесь выбираются основные параметры: количество карточек и коллекция (в будущем)
//
final class MainMenuViewController: UIViewController, UpdateCardCollection {
    //  По умолчанию стоит 16 карточек для игры
    private var cardCount: Int = 0
    //  Коллекция карточек. сюда будет загружаться в дальнейшем коллекции из памяти
    private var cardCollection16: [ImageModel] = []
    private var cardCollection36: [ImageModel] = []
    private var currentCardCollection: [ImageModel] = []
    //  Кнопка для запуска игры
    private  let gameButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(loadGame))
            .set(title: "GAME")
            .build()
        return button
    }()
    //  Кнопка, по которой задается 16 карточек
    private let easyLVLButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(tapEasyButton))
            .set(title: "16")
            .build()
        return button
    }()
    //  Кнопка, по которой задается 32 карточки
    private let hardLVLButton: UIButton = {
        let button = ButtonBuilder().set(selector: #selector(tapHardButton))
            .set(title: "36")
            .build()
        return button
    }()
    
    private let collectionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(chooseCardCollection), for: .touchDown)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        return button
    }()
    //  текст на экране, призывающий выбрать сложность
    private let text: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = "Выберите сложность"
        text.textAlignment = .center
        text.contentInset = UIEdgeInsets(top: 120, left:0, bottom: 10, right:0)
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .clear
        text.alpha = 0.5
        text.layer.cornerRadius = 15
        return text
    }()
    
    //  здесь в дальнейшем будет отображена одна из картинок выбранной коллекции
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    //  устанавливаем расположение наших кнопок и картинки
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = view.frame.height
        let width = view.frame.width
        let heightButton = height/8
        let widthLVLButton = width/45*14
        let widthGameButton = width/3*2
        let deltaBetweenButton = (13/16 - 1/45 - 1/8) * height
        cardCount = 16
        changeButton()
        makeBaseCardCollection()
        
        gameButton.frame = CGRect(x: width/6, y: height/16*13, width: widthGameButton, height: heightButton)
        easyLVLButton.frame = CGRect(x: width/6, y: deltaBetweenButton, width:  widthLVLButton, height: heightButton)
        hardLVLButton.frame = CGRect(x: width/90*47, y: deltaBetweenButton, width:  widthLVLButton, height: heightButton)
        mainImageView.frame = CGRect(x: width/6, y: height/8, width: widthGameButton, height: height/16*7)
        text.frame = CGRect(x: width/6, y: height/12*7, width: widthGameButton, height: heightButton/2)
        
        collectionButton.frame = mainImageView.frame
    }
    
    //  добавляем кнопки и картинки на view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        view.backgroundColor = .cyan
        view.addSubview(gameButton)
        view.addSubview(easyLVLButton)
        view.addSubview(hardLVLButton)
        view.addSubview(mainImageView)
        view.addSubview(text)
        view.addSubview(collectionButton)
    }
    
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapEasyButton() {
        cardCount = 16
        changeButton()
        currentCardCollection = cardCollection16
        mainImageView.image = currentCardCollection[0].image
    }
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        cardCount = 36
        changeButton()
        currentCardCollection = cardCollection36
        mainImageView.image = currentCardCollection[0].image
    }
    //  функция относится к кнопке, запускающей игру. На данном этапе в ней формируется коллекция, настраиваются параметры для следующего viewController'a и загружается следующий экран
    @objc private func loadGame() {
        if currentCardCollection.count == 0 {
            print("Коллекция пуста")
        } 
        let gameMenu = GameMenuViewController()
        gameMenu.cardCollection = currentCardCollection
        navigationController?.pushViewController(gameMenu, animated: true)
    }
    
    @objc private func chooseCardCollection() {
        let collectionViewController = ChooseCollectionViewController()
        collectionViewController.changeCardCollection = self
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
    // функция, создающая коллекцию. Т.к. по логике игры у нас четное количество карточек, то мы смело делим на 2 (игра по отысканию пар) и заполняем коллекцию карточками и их копиями
    private func makeCardCollection(collection: [ImageModel])-> [ImageModel]{
        cardCount = collection.count * 2
        changeButton()
        var newCollection = [ImageModel]()
        
        for i in 0..<collection.count {
            newCollection.append(collection[i])
            newCollection.append(collection[i])
        }
        currentCardCollection = newCollection
        return newCollection
    }
    
    private func makeBaseCardCollection() {
        cardCollection16 = []
        cardCollection36 = []
        
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
        mainImageView.image = currentCardCollection[0].image
    }
    
    private func changeButton(){
        switch cardCount {
        case 16:
            do {
                easyLVLButton.backgroundColor = .darkGray
                hardLVLButton.backgroundColor = .lightGray
            }
        case 36:
            do {
                easyLVLButton.backgroundColor = .lightGray
                hardLVLButton.backgroundColor = .darkGray
            }
        default:
            print("error")
        }
    }
    
    //    MARK: -UpdateCardCollection
    
    func udpateCardCollection(newCardCollection: [ImageModel]){
        mainImageView.image = newCardCollection[0].image
        switch newCardCollection.count {
        case 8:
            do {
                cardCollection16 = makeCardCollection(collection: newCardCollection)
            }
        case 18:
            do {
                cardCollection36 = makeCardCollection(collection: newCardCollection)
            }
        default:
            print("Ошибка в количестве карточек")
        }
    }
}

