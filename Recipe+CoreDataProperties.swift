//
//  Recipe+CoreDataProperties.swift
//  Reciplease
//
//  Created by Simon Dahan on 03/06/2021.
//
//

import Foundation
import CoreData

extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var yield: Int32
    @NSManaged public var totalTime: Int32
    @NSManaged public var image: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var url: String?

}

extension Recipe: Identifiable {

}
