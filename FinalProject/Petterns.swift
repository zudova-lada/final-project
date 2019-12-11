//
//  Petterns.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

// MARK: -Builder
final class ButtonBuilder{
    
    private var button: UIButton
    
    init() {
        self.button = UIButton()
    }
    
    func set(title: String) -> ButtonBuilder {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return self
    }
    
    func set(selector: Selector) -> ButtonBuilder {
        button.addTarget(self, action: selector, for: .touchDown)
        return self
    }
    
    func build() -> UIButton {
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.alpha = 0.85
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3
        return self.button
    }
}

// MARK: -CoR

protocol HandlerAPI {
    
    var next: HandlerAPI? { get }
    
    func handle(_ request: Request) -> LocalizedError?
}

protocol Request {
    
    var baseUrl:String? {get}
    
    var methodItem:String? {get}
    var apiKeyItem:String? {get}
    var formatItem:String? {get}
    var nojsoncallbackItem:String? {get}
    
}

extension Request {
    var baseUrl:String? { return nil }
    
    var methodItem:String? { return nil }
    var apiKeyItem:String? { return nil }
    var formatItem:String? { return nil }
    var nojsoncallbackItem:String? { return nil }
}

struct UrlRequest: Request {
    var baseUrl:String?
    
    var methodItem:String?
    var apiKeyItem:String?
    var formatItem:String?
    var nojsoncallbackItem:String?
}

class BaseHandler: HandlerAPI {
    var next: HandlerAPI?
    
    init(with handler: HandlerAPI? = nil) {
        self.next = handler
    }
    
    func handle(_ request: Request) -> LocalizedError? {
        return next?.handle(request)
    }
    
}


class BaseURLHandler: BaseHandler {
    
    private let baseURL = "https://www.flickr.com/services/rest/"
    
    override func handle(_ request: Request) -> LocalizedError? {
        guard request.baseUrl == baseURL else {
            return AuthError.baseUrl
        }
        
        return next?.handle(request)
    }
}

class APIItemsHandler: BaseHandler {
    override func handle(_ request: Request) -> LocalizedError? {
        guard request.methodItem?.isEmpty == false else {
            return AuthError.methodItem
        }
        
        guard request.apiKeyItem?.isEmpty == false else {
            return AuthError.apiKeyItem
        }
        
        guard request.formatItem?.isEmpty == false else {
            return AuthError.formatItem
        }
        
        guard request.nojsoncallbackItem?.isEmpty == false else {
            return AuthError.nojsoncallbackItem
        }
        
        return next?.handle(request)
    }
}

enum AuthError: LocalizedError {
    
    case baseUrl
    
    case methodItem
    case apiKeyItem
    case formatItem
    case nojsoncallbackItem
    
    var errorDescription: String? {
        switch self {
        case .baseUrl:
            return "Url is incorrect"
        case .methodItem:
            return "Method is empty"
        case .apiKeyItem:
            return "Api_key is empty"
        case .formatItem:
            return "Format is incorrect"
        case .nojsoncallbackItem:
            return "Nojsoncallback is not 1"
            
        }
    }
}

protocol AuthHandlerSupportable: AnyObject {
    
    var handler: HandlerAPI? { get set }
}

// MARK: -Mediator

protocol Mediator: AnyObject {
    func notify(sender: BaseComponent, event: String)
}

class BaseComponent: NSObject {
    
    weak var mediator: Mediator?
    
    init(mediator: Mediator? = nil) {
        self.mediator = mediator
    }
    
    func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

