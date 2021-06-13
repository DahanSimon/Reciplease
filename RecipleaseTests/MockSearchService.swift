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
    var responseCode: Int
    init(expectedResult: [Recipe], responseCode: Int) {
        self.expectedResult = expectedResult
        self.responseCode = responseCode
    }
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<[Recipe], SearchErrors>) -> Void) {
        var result: Result<[Recipe], SearchErrors> {
            if responseCode == 200 {
                return .success(expectedResult)
            } else {
                return.failure(.apiError)
            }
        }
        callback(result)
    }
}
