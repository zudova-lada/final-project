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
    
    func fetchData16()-> [CollectionHelper]{
        print("Fetching Data..")
        
        do {
            request.predicate = NSPredicate(format: "count == %d", Int16(16))
            collectionNames16 = try context.fetch(request)
        } catch {
            print(error)
        }
        
        return collectionNames16
    }
    
    func fetchData36()-> [CollectionHelper]{
        print("Fetching Data..")
        
        do {

            request.predicate = NSPredicate(format: "count == %d", Int16(36))
            collectionNames36 = try context.fetch(request)
        } catch {
            print(error)
        }
        
        return collectionNames36
    }
}
