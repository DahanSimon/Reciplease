//
//  SearchService.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

class Search {
    static var recipeList: [Recipe] = []
    var api: RecipeSearchProtocol
    
    init(api: RecipeSearchProtocol) {
        self.api = api
    }
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<[Recipe], SearchErrors>) -> Void) {
        Search.recipeList = []
        api.getRecipes(ingredients: ingredients) { recipeList in
            switch recipeList {
            case .success(let response):
                if response.count == 0 {
                    callback(Result.failure(SearchErrors.noRecipeFound))
                }
                Search.recipeList = response
                callback(recipeList)
            case .failure(_):
                callback(recipeList)
            }
            
        }
    }
}
