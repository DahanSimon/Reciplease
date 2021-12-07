//
//  Recipe+CoreDataProperties.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//
//

import Foundation
import CoreData

extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
}

extension Recipe: Identifiable {

}
