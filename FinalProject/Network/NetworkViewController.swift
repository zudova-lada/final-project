//
//  AddImageFromNetwork.swift
//  FinalProject
//
//  Created by Лада on 09/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

protocol SelectImage {
    func selectImage(image: UIImage)
}


final class NetworkViewController: UIViewController, Mediator {
    
    func notify(sender: BaseComponent, event: String) {
        if event == "search" {
            searchString = self.searchComponent.getSearchText()
            search()
        }
        
        if event == "select Image" {
            
            selectImage(image: tableDelegate.getImage())
        }
    }
    
    
    var addCard: SelectImage!
    
    private let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    private var images: [ImageModel] = []
    private let reuseId = "UITableViewCellreuseId"
    private let interactor: InteractorInput
    private var searchController: UISearchController!
    private var searchActive : Bool = false
    private var localModels: [ImageNetworkModel] = []
    private let dataSource = TableDataSource()
    private var searchString: String  = ""
    private var tableDelegate = TableDelegate()
    private var searchComponent = NetworkSearchBarDelegate()

    init(interactor: InteractorInput) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        searchController = UISearchController(searchResultsController: nil)
//        tableDelegate.selectImage = self
        tableView.delegate = tableDelegate
        tableView.tableHeaderView = searchController.searchBar
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        searchController.searchBar.delegate = searchComponent
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseId)
        
        tableView.frame = CGRect.init(origin: .zero, size:view.frame.size)
        
        searchComponent.update(mediator: self)
        tableDelegate.update(mediator: self)
        
        
        
    }
    
    @objc private func search() {
        images = []
        interactor.loadImageList(by: searchString) { [weak self] models in
            
            self?.loadImages(with: models)
        }
    }
    
    private func loadImages(with models: [ImageNetworkModel]) {
        let models = models.suffix(20)
        let group = DispatchGroup()
        for model in models {
            group.enter()
            interactor.loadImage(at: model.path) { [weak self] image in
                guard let image = image else {
                    group.leave()
                    return
                }
                let viewModel = ImageModel(name: model.description,
                                           image: image)
                self?.images.append(viewModel)
                group.leave()
            }
            
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.dataSource.images = self.images
            self.tableView.reloadData()
        }
    }
    private func loadOneImage(row: Int) {
        let imagePath = localModels[row].path
        interactor.loadImage(at: imagePath) { [weak self] image in
            if let image = image {
                let model = ImageModel(name: self!.localModels[row].description, image: image)
                self?.images[row] = model
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func selectImage(image: UIImage) {
        addCard.selectImage(image: image)
        navigationController?.popViewController(animated: true)
    }
}






