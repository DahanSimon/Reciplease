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

func removeRecipe(at name: String){
    let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    guard let filteredRecipes = try? AppDelegate.viewContext.fetch(request) else {
        return
    }
    // Boucle for pour supprimer tout les resultats
    for recipe in filteredRecipes {
        AppDelegate.persistentContainer.viewContext.delete(recipe)
    }
}

func resetAllRecords(in entity : String)
{
    let context = AppDelegate.viewContext
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
    catch
    {
        print ("There was an error")
    }
}
