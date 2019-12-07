//
//  ImageStructure+CoreDataProperties.swift
//  FinalProject
//
//  Created by Лада on 06/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageStructure {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageStructure> {
        return NSFetchRequest<ImageStructure>(entityName: "ImageStructure")
    }

    @NSManaged public var collectionName: String
    @NSManaged public var image: NSData
    @NSManaged public var name: String

}
