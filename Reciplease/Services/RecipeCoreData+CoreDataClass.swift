//
//  RecipeCoreData+CoreDataClass.swift
//  Reciplease
//
//  Created by Simon Dahan on 16/06/2021.
//
//

import Foundation
import CoreData

public class RecipeCoreData: NSManagedObject {
    static var coreDataStack = CoreDataStack()
    static var all: [Recipe] {
            let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
        guard let coreDataRecipes = try? coreDataStack.mainContext.fetch(request) else {
                return []
            }
            var recipes: [Recipe] = []
            for recipe in coreDataRecipes {
                recipes.append(Recipe(apiRecipe: nil, coreDataRecipe: recipe))
            }
            return recipes
        }
}
