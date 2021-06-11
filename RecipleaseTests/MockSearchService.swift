//
//  MockSearchService.swift
//  RecipleaseTests
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation
@testable import Reciplease

class MockSearchService: RecipeSearchProtocol {
    var expectedResult: [Recipe]
    init(expectedResult: [Recipe]) {
        self.expectedResult = expectedResult
    }
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<[Recipe], SearchErrors>) -> Void) {
        let result = Result<[Recipe], SearchErrors>.success(expectedResult)
        callback(result)
    }
}
