//
//  FinalProjectTests.swift
//  FinalProjectTests
//
//  Created by Лада on 11/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import XCTest
import UIKit
@testable import FinalProject

class MainMenuInputSpy: MainMenuInput {

    var result = false

    func errorMessage(errorMessage: String) {
        result = true
    }

}

class ChooseCollectionSpy: ChooseCollectionInput {
    func updateDataSource(with model: ImagesModel) {
        
    }
    
    func loadingCollection() {
        
    }
    
    func endOfLoading() {
        
    }
    
    func getCurrentDataCount() -> Int {
        return 2
    }
    
    
}


class FinalProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_WhereGameModelChamgeCardCount_MainMenuGetBadResult() {
//         arrange
        let gameModel = GameModel()
        let mainMenu = MainMenuInputSpy()
        gameModel.mainMenu = mainMenu
//         act
        gameModel.changeCardCount(cardCount: 18)
//         assert
        XCTAssert(mainMenu.result, "Неверная обработка")
        
    }


}


// arrange

// act

// assert

