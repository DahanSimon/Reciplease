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
        let ingredientName: String = "Tomato"
        let recipe = ApiRecipe(label: "Pizza", image: "pizza", url: "example.com", yield: 2,  ingredientLines: ["250gr Pizza Dough", "100gr Tomato Sacue", "100gr Mozzarella"], ingredients: [Ingredient(text: "Pizza Dough", weight: 255.0), Ingredient(text: "Tomato Sauce", weight: 100.0), Ingredient(text: "Mozzarella", weight: 100.0)])
        let founds = Founds(recipe: recipe)
        
        let searchRecipeMock = MockSearchService(expectedResult: RecipeList(q: ingredientName, from: 0, to: 5, more: false, count: 1, hits: [founds]))
        let searchService = Search(api: searchRecipeMock)
        // When
        let expectation = XCTestExpectation(description: "Wait for convertion to be done")
        
        var recipeList: RecipeList?
        searchService.getRecipes { response in
            if let success = try? response.get() {
                recipeList = success
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
        XCTAssertNotNil(recipeList)
    }
}
