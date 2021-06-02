//
//  SearchService.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

class SearchService: RecipeSearchProtocol {
    func getRecipes(callback: @escaping (Result<RecipeList?, Error>) -> Void) {
        let recipeList: RecipeList? = nil
        let result = Result {
            recipeList
        }
        callback(result)
    }
}
