//
//  MockSearchService.swift
//  RecipleaseTests
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation
@testable import Reciplease

class MockSearchService: RecipeSearchProtocol {
    
    
    var expectedResult: RecipeList?
    
    init(expectedResult: RecipeList?) {
        self.expectedResult = expectedResult
    }
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<RecipeList?, SearchErrors>) -> Void) {
        let result = Result<RecipeList?, SearchErrors>.success(expectedResult)
        callback(result)
    }
}
