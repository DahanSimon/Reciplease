//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Simon Dahan on 25/05/2021.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {

    func testSearchRecipeWithOneIngredientShouldGetRecipeList() {
        // Given
        let ingredients: [String] = ["Tomato","Cheese","Pizza Dough"]
        let recipe = ApiRecipe(label: "Pizza", image: "pizza", url: "example.com", yield: 2,  ingredientLines: ["250gr Pizza Dough", "100gr Tomato Sacue", "100gr Mozzarella"], ingredients: [Ingredient(text: "Pizza Dough", weight: 255.0), Ingredient(text: "Tomato Sauce", weight: 100.0), Ingredient(text: "Mozzarella", weight: 100.0)], totalTime: 50)
        let founds = Founds(recipe: recipe)
        
        let searchRecipeMock = MockSearchService(expectedResult: RecipeList(q: ingredients.joined(), from: 0, to: 5, more: false, count: 1, hits: [founds]))
        let searchService = Search(api: searchRecipeMock)
        // When
        let expectation = XCTestExpectation(description: "Wait for recipeList to be acquired")
        
        var recipeList: RecipeList?
        searchService.getRecipes(ingredients: ingredients) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    recipeList = success
                    expectation.fulfill()
                case .failure(_):
                    break
                }
            }
        }

        wait(for: [expectation], timeout: 0.10)
        XCTAssertNotNil(recipeList)
    }
}
