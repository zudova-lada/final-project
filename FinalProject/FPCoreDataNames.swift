//
//  FPCoreDataNames.swift
//  FinalProject
//
//  Created by Лада on 06/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit
import CoreData

class FPCoreDataNames {
    
    var context: NSManagedObjectContext!
    var collectionNames16 = [CollectionHelper]()
    var collectionNames36 = [CollectionHelper]()
    let request: NSFetchRequest<CollectionHelper> = CollectionHelper.fetchRequest()
    
    
    func createPersistentContainer() {
        let container = NSPersistentContainer(name: "FPCollectionNames")
        container.loadPersistentStores(completionHandler: { (images, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        context = container.viewContext
    }
    
    func saveContext() {

            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        
        
    }
    
    func deleteAllElements () {
        request.predicate =  nil
        
        do {
            collectionNames16 = try context.fetch(request)
            for data in collectionNames16 {
                context.delete(data)
            }
            
        } catch {
            print(error)
        }
        
        do {
            collectionNames36 = try context.fetch(request)
            for data in collectionNames36 {
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
    
    func fetchData16()-> [ImagesModel]{
        print("Fetching Data..")
        
        do {
            request.predicate = NSPredicate(format: "count == %@", "8")
            collectionNames16 = try context.fetch(request)
        } catch {
            print(error)
        }
        
        var imagesModel = [ImagesModel]()
        
        for item in collectionNames16 {
            var imageArray = [UIImage]()
            imageArray.append(UIImage(data: item.image1 as Data, scale: 0.01)!)
            imageArray.append(UIImage(data: item.image2 as Data, scale: 0.01)!)
            imageArray.append(UIImage(data: item.image3 as Data, scale: 0.01)!)
            imageArray.append(UIImage(data: item.image4 as Data, scale: 0.01)!)
            let image = ImagesModel(name: item.collectionName, images: imageArray)
            imagesModel.append(image)
            
        }
        
        return imagesModel
    }
    
    func fetchData36()-> [ImagesModel]{
        print("Fetching Data..")
        
        do {

            request.predicate = NSPredicate(format: "count == %@", "18")
            collectionNames36 = try context.fetch(request)
        } catch {
            print(error)
        }
        
        var imagesModel = [ImagesModel]()
        
        for item in collectionNames36 {
            var imageArray = [UIImage]()
            imageArray.append(UIImage(data: item.image1 as Data, scale: 0.01)!)
            imageArray.append(UIImage(data: item.image2 as Data, scale: 0.01)!)
            imageArray.append(UIImage(data: item.image3 as Data, scale: 0.01)!)
            imageArray.append(UIImage(data: item.image4 as Data, scale: 0.01)!)
            let image = ImagesModel(name: item.collectionName, images: imageArray)
            imagesModel.append(image)

        }
        
        return imagesModel
    }
}
