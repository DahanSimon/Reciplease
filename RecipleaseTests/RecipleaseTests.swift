//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Simon Dahan on 25/05/2021.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {

    func testSearchRecipeWithOneIngredientShouldGetRecipeArray() {
        // Given
        let ingredients: [String] = ["Tomato", "Cheese", "Pizza Dough"]
        let recipe = ApiRecipe(uri: "example.com", label: "Pizza", image: "pizza", url: "example.com", yield: 2, ingredientLines: ["250gr Pizza Dough", "100gr Tomato Sacue", "100gr Mozzarella"], ingredients: [Ingredient(text: "Pizza Dough", weight: 255.0), Ingredient(text: "Tomato Sauce", weight: 100.0), Ingredient(text: "Mozzarella", weight: 100.0)], totalTime: 50)
        let searchRecipeMock = MockSearchService(expectedResult: [Recipe(apiRecipe: recipe, coreDataRecipe: nil)], responseCode: 200)
        let searchService = Search(api: searchRecipeMock)
        // When
        let expectation = XCTestExpectation(description: "Wait for recipeList to be acquired")
        var recipeList: [Recipe]?
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
    func testSearchRecipeWithWrongIngredientsShouldGetError() {
        // Given
        let ingredients: [String] = [" ", " ", " "]
        let searchRecipeMock = MockSearchService(expectedResult: [], responseCode: 200)
        let searchService = Search(api: searchRecipeMock)
        // When
        let expectation = XCTestExpectation(description: "Wait for recipeList to be acquired")
        
        var recipeList: [Recipe]?
        var error: SearchErrors?
        searchService.getRecipes(ingredients: ingredients) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    recipeList = success
                    expectation.fulfill()
                case .failure(let resultError):
                    error = resultError
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation], timeout: 0.10)
        XCTAssertNotNil(error)
        XCTAssertEqual(recipeList?.count, 0)
    }
    
    func testSearchRecipeAndApiReturnWrongStatusCodeShouldGetError() {
        // Given
        let ingredients: [String] = [" ", " ", " "]
        let searchRecipeMock = MockSearchService(expectedResult: [], responseCode: 400)
        let searchService = Search(api: searchRecipeMock)
        // When
        let expectation = XCTestExpectation(description: "Wait for recipeList to be acquired")
        
        var recipeList: [Recipe]?
        var error: SearchErrors?
        searchService.getRecipes(ingredients: ingredients) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    recipeList = success
                    expectation.fulfill()
                case .failure(let resultError):
                    error = resultError
                    expectation.fulfill()
                }
            }
        }
        print(RecipeCoreData.all.count)

        wait(for: [expectation], timeout: 0.10)
        XCTAssertNotNil(error)
        XCTAssertNil(recipeList)
    }
}
