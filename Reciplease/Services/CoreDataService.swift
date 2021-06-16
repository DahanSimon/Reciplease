//
//  CoreDataService.swift
//  Reciplease
//
//  Created by Simon Dahan on 14/06/2021.
//

import Foundation
import CoreData

public class CoreDataService {
    // MARK: - Properties
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.managedObjectContext = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    func saveRecipe(likedRecipe: Recipe, coreDataTask: CoreDataStack) -> Bool {
        let recipe = RecipeCoreData(context:  coreDataTask.mainContext)
        recipe.uri = likedRecipe.uri
        recipe.image = likedRecipe.imageUrl
        recipe.name = likedRecipe.name
        recipe.totalTime = Int32(likedRecipe.totalTime!)
        recipe.url = likedRecipe.directionUrl
        recipe.yield = Int32(likedRecipe.yield!)
        recipe.ingredients = likedRecipe.ingredients!.joined(separator: ",")
        return coreDataStack.saveContext()
        
    }

    func removeRecipe(uri: String) -> Bool {
        let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", uri)
        guard let filteredRecipes = try? coreDataStack.mainContext.fetch(request) else {
            return false
        }
        for recipe in filteredRecipes {
            coreDataStack.storeContainer.viewContext.delete(recipe)
            do {
                try  coreDataStack.mainContext.save()
                
            } catch {
                return false
            }
        }
        return true
    }

    func resetAllRecords(in entity : String) -> Bool {
        let context = CoreDataStack().mainContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        }  catch {
            print ("There was an error")
            return false
        }
        return true
    }
}
