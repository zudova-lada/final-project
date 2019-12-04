//
//  ViewController.swift
//  FinalProject
//
//  Created by Лада on 25/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit


//  Главное меню игры, здесь выбираются основные параметры: количество карточек и коллекция (в будущем)
//
class FPMainMenuViewController: UIViewController {
//  По умолчанию стоит 16 карточек для игры
    private var cardCount: Int = 16
//  Коллекция карточек. сюда будет загружаться в дальнейшем коллекции из памяти
    var cardCollection: [ImageModel] = []
//  Кнопка для запуска игры
    private  let gameButton: UIButton = {
        let button = UIButton()
        button.setTitle("GAME", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(loadGame), for: .touchDown)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        return button
    }()
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
//  текст на экране, призывающий выбрать сложность
    let text: UITextView = {
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
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
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
        
        gameButton.frame = CGRect(x: width/6, y: height/16*13, width: widthGameButton, height: heightButton)
        easyLVLButton.frame = CGRect(x: width/6, y: deltaBetweenButton, width:  widthLVLButton, height: heightButton)
        hardLVLButton.frame = CGRect(x: width/90*47, y: deltaBetweenButton, width:  widthLVLButton, height: heightButton)
        mainImageView.frame = CGRect(x: width/6, y: height/8, width: widthGameButton, height: height/16*7)
        text.frame = CGRect(x: width/6, y: height/12*7, width: widthGameButton, height: heightButton/2)
        
    }
    
//  добавляем кнопки и картинки на view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        view.backgroundColor = .green
        view.addSubview(gameButton)
        view.addSubview(easyLVLButton)
        view.addSubview(hardLVLButton)
        view.addSubview(mainImageView)
        view.addSubview(text)
    }
  
//    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapEasyButton() {
        cardCount = 16
    }
//    функция относится к кнопке и переключает количество карточек на нужное нам число
    @objc private func tapHardButton() {
        cardCount = 36
    }
//  функция относится к кнопке, запускающей игру. На данном этапе в ней формируется коллекция, настраиваются параметры для следующего viewController'a и загружается следующий экран
    @objc private func loadGame() {
        makeCardCollection()
        let gameMenu = FPGameMenuViewController()
        gameMenu.cardCollection = cardCollection
        navigationController?.pushViewController(gameMenu, animated: true)
    }
// функция, создающая коллекцию. Т.к. по логике игры у нас четное количество карточек, то мы смело делим на 2 (игра по отысканию пар) и заполняем коллекцию карточками и их копиями
    func makeCardCollection() {
        cardCollection = []
        let firstCardCount = Int(cardCount/2)
        
        for i in 0..<firstCardCount {
            let name = String(i)
            let card = ImageModel(name: name, image: UIImage(named: name)!)
            cardCollection.append(card)
            cardCollection.append(card)
        }
    }
}

