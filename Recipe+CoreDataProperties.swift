//
//  Recipe+CoreDataProperties.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recipe {

    @NSManaged var directions: String?
    @NSManaged var ingredients: String?
    @NSManaged var link: String?
    @NSManaged var time: NSNumber?
    @NSManaged var name: String?
    @NSManaged var servings: NSNumber?
    @NSManaged var category: Category?
    @NSManaged var image: Image?

}
