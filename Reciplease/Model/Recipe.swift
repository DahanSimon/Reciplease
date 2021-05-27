//
//  Recipe.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {
    static var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return recipes
    }
    
    var ingredientList: [Ingredient] = []
}
