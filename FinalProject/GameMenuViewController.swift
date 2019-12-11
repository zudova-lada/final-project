//
//  SecondMenuViewController.swift
//  FinalProject
//
//  Created by Лада on 27/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol UpdateGamePoints {
    func addPointsToGamer(gamerNumber: Int)
}

// здесь идет сама игра
// из предыдущего контроллера передается коллекция карточек
// здесь ведется подсчет очков и изменяются параметры у вью
final class GameMenuViewController: UIViewController, UpdateGamePoints {
    
    var cardCollection: [ImageModel]!
    
    private var cardCollectionView: UICollectionView!
    private let dataSource = CardsCollectionViewDataSource()
    private let delegate = CardCollectionViewDelegate()
    private let layout = CardCollectionViewFlowLayout()
    //    параметры игры: очки первого игрока, второго игрока и количество оставшихся очков, по которым определяется, завершена ли игра
    private var pointsGamer1 = 0
    private var pointsGamer2 = 0
    private var gameCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.gameMenuViewController = self
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        cardCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), collectionViewLayout: layout)
        cardCollectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        dataSource.cardCollection = cardCollection
        cardCollectionView.dataSource = dataSource
        cardCollectionView.delegate = delegate
        cardCollectionView.isScrollEnabled = false
        
        cardCollectionView.frame = CGRect(x: 0, y: 2*(navigationController?.navigationBar.frame.height ?? 0), width: view.frame.width, height:view.frame.width + 6)
        cardCollectionView.backgroundColor = .blue
        view.backgroundColor = UIColor.red
        //        устанавливаем количество очков, равных количеству карточек
        gameCount = cardCollection.count
        
        
        //        настраиваем расположение объектов
        let height = view.frame.height
        let width = view.frame.width
        
        textGamer1.frame = CGRect(x: view.frame.width/10, y: height/8*6, width: width/4*1, height: height/16)
        textGamer2.frame = CGRect(x: view.frame.width/10 + width/2*1, y: height/8*6, width: width/4*1, height: height/16)
        
        textPointGamer1.frame = CGRect(x: view.frame.width/10, y: height/8*7, width: width/4*1, height: height/16)
        textPointGamer2.frame = CGRect(x: view.frame.width/10 + width/2*1, y: height/8*7, width: width/4*1, height: height/16)
        
        textPointGamer1.text = String(pointsGamer1)
        textPointGamer2.text = String(pointsGamer2)
    }
    //   добавляем наши объекты
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .blue
        view.addSubview(cardCollectionView)
        view.addSubview(textGamer1)
        view.addSubview(textGamer2)
        view.addSubview(textPointGamer1)
        view.addSubview(textPointGamer2)
    }
    //    функция, отвечающая за добавление очков игроку, чей номер передается в gamerNumber
    //    так же ведет подсчет количества оставшихся очков, удаляя по 2 очка при правильном ответе (неправильный ответ не передается)
    func addPointsToGamer(gamerNumber: Int) {
        switch gamerNumber {
        case 1:
            do {
                self.pointsGamer1 += 1
                self.textPointGamer1.text = String(self.pointsGamer1)
                gameCount -= 2
            }
        case 2:
            do {
                self.pointsGamer2 += 1
                self.textPointGamer2.text = String(self.pointsGamer2)
                gameCount -= 2
            }
            
        default:
            print("Такого игрока нет")
        }
        // когда количество карточек доходит до 0, тогда и количество очков становится 0
        // и появляется сообщение об окончании игры, а так же выдаются результаты игры
        if gameCount == 0 {
            
            if pointsGamer1 > pointsGamer2 {
                textGameOver.text = "Игра закончена!\nПобедил игрок \(String( textGamer1.text))"
            }
            
            if pointsGamer1 < pointsGamer2 {
                textGameOver.text = "Игра закончена!\nПобедил игрок \(String(textGamer2.text))"
            }
            
            if pointsGamer1 == pointsGamer2{
                textGameOver.text = "Игра закончена!\nНичья"
            }
            
            
            textGameOver.frame = CGRect(x: view.frame.width/3, y: view.frame.height/2, width: view.frame.width/3, height: 100)
            view.addSubview(textGameOver)
        }
    }
    
    private let textGameOver: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        return text
    }()
    
    private let textGamer1: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = "Игрок 1"
        text.textAlignment = .center
        text.contentInset = UIEdgeInsets(top: 120, left:0, bottom: 10, right:0)
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        return text
    }()
    
    private let textGamer2: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = "Игрок 2"
        text.textAlignment = .center
        text.contentInset = UIEdgeInsets(top: 120, left:0, bottom: 10, right:0)
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        return text
    }()
    
    private let textPointGamer1: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = ""
        text.textAlignment = .center
        text.contentInset = UIEdgeInsets(top: 120, left:0, bottom: 10, right:0)
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        return text
    }()
    
    private let textPointGamer2: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = ""
        text.textAlignment = .center
        text.contentInset = UIEdgeInsets(top: 120, left:0, bottom: 10, right:0)
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        return text
    }()
}
