//
//  Recipe+CoreDataClass.swift
//  Reciplease
//
//  Created by Simon Dahan on 03/06/2021.
//
//

import Foundation
import CoreData

public class RecipeCoreData: NSManagedObject {
    static var all: [Recipe] {
        let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
        guard let coreDataRecipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        var recipes: [Recipe] = []
        for recipe in coreDataRecipes {
            recipes.append(Recipe(apiRecipe: nil, coreDataRecipe: recipe))
        }
        return recipes
    }
}

func saveRecipe(likedRecipe: Recipe) {
    let recipe = RecipeCoreData(context: AppDelegate.viewContext)
    recipe.uri = likedRecipe.uri
    recipe.image = likedRecipe.imageUrl
    recipe.name = likedRecipe.name
    recipe.totalTime = Int32(likedRecipe.totalTime!)
    recipe.url = likedRecipe.directionUrl
    recipe.yield = Int32(likedRecipe.yield!)
    recipe.ingredients = likedRecipe.ingredients!.joined(separator: ",")
    try? AppDelegate.viewContext.save()
}

func removeRecipe(uri: String){
    let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
    request.predicate = NSPredicate(format: "uri == %@", uri)
    guard let filteredRecipes = try? AppDelegate.viewContext.fetch(request) else {
        return
    }
    for recipe in filteredRecipes {
        AppDelegate.persistentContainer.viewContext.delete(recipe)
        try? AppDelegate.viewContext.save()
    }
}

func resetAllRecords(in entity : String) {
    let context = AppDelegate.viewContext
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do {
            try context.execute(deleteRequest)
            try context.save()
    }
    catch {
        print ("There was an error")
    }
}


