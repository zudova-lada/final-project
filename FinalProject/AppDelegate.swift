//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Лада on 25/11/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let gameModel = GameModel()
        let mainViewController = MainMenuViewController()
        let collectionViewController = ChooseCollectionViewController()
        gameModel.chooseCollection = collectionViewController
        gameModel.mainMenu = mainViewController
        
        collectionViewController.gameModel = gameModel
        mainViewController.collectionViewController = collectionViewController
        mainViewController.gameModel = gameModel
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}

