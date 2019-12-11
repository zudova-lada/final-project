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

protocol MainMenuInput {
    func errorMessage(errorMessage: String)
}


//  Главное меню игры, здесь выбираются основные параметры: количество карточек и коллекция (в будущем)
//
final class MainMenuViewController: UIViewController, MainMenuInput {
    
    var gameModel:MainMenuOutput!
    var collectionViewController: ChooseCollectionViewController!
    
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
        changeButton()
        
        mainImageView.image = gameModel.giveCurrentCollectionImage()
        
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
        gameModel.changeCardCount(cardCount: 16)
        changeButton()
        mainImageView.image = gameModel.giveCurrentCollectionImage()
    }
    //    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        gameModel.changeCardCount(cardCount: 36)
        changeButton()
        mainImageView.image = gameModel.giveCurrentCollectionImage()
    }
    
    @objc private func loadGame() {
        let gameMenu = GameMenuViewController()
        gameMenu.cardCollection = gameModel.giveCurrentCardCollection()
        navigationController?.pushViewController(gameMenu, animated: true)
    }
    
    @objc private func chooseCardCollection() {
        
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
    
    private func changeButton(){
        
        let cardCount = gameModel.currectCardCount()
        
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
            errorMessage(errorMessage: "Ошибка в количестве карточек")
        }
    }
    
    //    MARK: MainMenuInput
    func errorMessage(errorMessage: String) {
        let errorMessage = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        errorMessage.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(errorMessage, animated: true)
    }
    
}

