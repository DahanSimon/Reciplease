//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Simon Dahan on 14/06/2021.
//

import XCTest
@testable import Reciplease
import CoreData

class CoreDataServiceTests: XCTestCase {

    var coreDataStack: CoreDataStack = TestCoreDataStack()
    var coreDataService: CoreDataService!
    

    override func setUp() {
      super.setUp()
        
      coreDataStack = TestCoreDataStack()
      coreDataService = CoreDataService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    func testAddRecipe() {
        var all: [Recipe]? {
            let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
            guard let coreDataRecipes = try? coreDataStack.mainContext.fetch(request) else {
                return nil
            }
            var recipes: [Recipe] = []
            for recipe in coreDataRecipes {
                recipes.append(Recipe(apiRecipe: nil, coreDataRecipe: recipe))
            }
            return recipes
        }
        var recipe = Recipe(apiRecipe: nil, coreDataRecipe: RecipeCoreData(context: coreDataStack.mainContext))
        recipe.ingredients = ["Cheese", "Banana"]
        let saved = coreDataService.saveRecipe(likedRecipe: recipe, coreDataTask: coreDataStack)
        XCTAssertTrue(saved)
    }
    
    func testRemoveRecipe() {
        var recipe = Recipe(apiRecipe: nil, coreDataRecipe: RecipeCoreData(context: coreDataStack.mainContext))
        recipe.ingredients = ["Cheese", "Banana"]
        recipe.uri = "URI"
        let saved = coreDataService.saveRecipe(likedRecipe: recipe, coreDataTask: coreDataStack)
        let removed = coreDataService.removeRecipe(uri: "URI")
        XCTAssertTrue(removed)
        XCTAssertTrue(saved)
    }
    
    func testRemoveAllTheRecipes() {
        var recipe = Recipe(apiRecipe: nil, coreDataRecipe: RecipeCoreData(context: coreDataStack.mainContext))
        recipe.ingredients = ["Cheese", "Banana"]
        recipe.uri = "URI"
        var recipe2 = Recipe(apiRecipe: nil, coreDataRecipe: RecipeCoreData(context: coreDataStack.mainContext))
        recipe2.ingredients = ["Cheese", "Banana"]
        recipe2.uri = "URI"
        let saved = coreDataService.saveRecipe(likedRecipe: recipe, coreDataTask: coreDataStack) && coreDataService.saveRecipe(likedRecipe: recipe2, coreDataTask: coreDataStack)
        let removedAll = coreDataService.resetAllRecords(in: "RecipeCoreData")
        XCTAssertTrue(removedAll)
        XCTAssertTrue(saved)
    }
    
    func testRemoveRecipeWithNoURIShouldGetAnError() {
        var recipe = Recipe(apiRecipe: nil, coreDataRecipe: RecipeCoreData(context: coreDataStack.mainContext))
        recipe.ingredients = ["Cheese", "Banana"]
        recipe.uri = "URI"
        let saved = coreDataService.saveRecipe(likedRecipe: recipe, coreDataTask: coreDataStack)
        let removed = coreDataService.removeRecipe(uri: "NIL")
        XCTAssertFalse(removed)
        XCTAssertTrue(saved)
    }
}
