//
//  RecipeCoreData+CoreDataProperties.swift
//  Reciplease
//
//  Created by Simon Dahan on 09/06/2021.
//
//

import Foundation
import CoreData


extension RecipeCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeCoreData> {
        return NSFetchRequest<RecipeCoreData>(entityName: "RecipeCodeData")
    }

    @NSManaged public var name: String?
    @NSManaged public var yield: Int32
    @NSManaged public var totalTime: Int32
    @NSManaged public var image: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var url: String?

}

extension RecipeCoreData : Identifiable {

}
