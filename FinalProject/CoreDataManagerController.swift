//
//  CoreDataManagerCollection.swift
//  FinalProject
//
//  Created by Лада on 06/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit
import CoreData

// MARK: -  Работа с CoreData

final class CoreDataManagerCollection {
    var context: NSManagedObjectContext!
    var lists = [ImageStructure]()
    let request: NSFetchRequest<ImageStructure> = ImageStructure.fetchRequest()
    let container = NSPersistentContainer(name: "CardCollection")
    
    func createPersistentContainer() {
        container.loadPersistentStores(completionHandler: { (images, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
    }
    
    func saveContext(imageCollection:  [ImageModel], collectionName: String, completion:((Bool)->(Void))?) {
        
        context = container.viewContext
        
        for item in imageCollection {
            
            let savingImage = ImageStructure(context: context)
            let imageToData = item.image.pngData()
            savingImage.name = item.name
            savingImage.image = NSData(data: imageToData!) as NSData
            savingImage.collectionName = collectionName
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        completion?(true)
    }
    
    func deleteAllElements () {
        context = container.viewContext
        do {
            request.predicate = nil
            lists = try context.fetch(request)
            for data in lists {
                context.delete(data)
            }
            
        } catch {
            print(error)
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData(nameCollection: String, collectionCount: Int)-> [ImageModel]{
        
        context = container.viewContext
        
        do {
            request.fetchLimit = collectionCount
            request.predicate = NSPredicate(format: "collectionName == %@", nameCollection)
            lists = try context.fetch(request)
        } catch {
            print(error)
        }
        
        var collectionCard: [ImageModel] = []
        
        for item in lists {
            let image = UIImage(data: item.image as Data, scale: 1)
            let card = ImageModel(name: item.name, image: image!)
            
            collectionCard.append(card)
        }
        
        return collectionCard
    }
    
}
