//
//  CollectionHelper+CoreDataProperties.swift
//  FinalProject
//
//  Created by Лада on 07/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//
//

import Foundation
import CoreData


extension CollectionHelper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CollectionHelper> {
        return NSFetchRequest<CollectionHelper>(entityName: "CollectionHelper")
    }

    @NSManaged public var collectionName: String
    @NSManaged public var image1: NSData
    @NSManaged public var image2: NSData
    @NSManaged public var image3: NSData
    @NSManaged public var image4: NSData
    @NSManaged public var count: Int16

}
