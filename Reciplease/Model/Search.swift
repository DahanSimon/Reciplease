//
//  SearchService.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

class Search {
    var api: RecipeSearchProtocol
    
    init(api: RecipeSearchProtocol) {
        self.api = api
    }
    
    func getRecipes(callback: @escaping (Result<RecipeList?, Error>) -> Void) {
        api.getRecipes { recipeList in
            callback(recipeList)
        }
    }
}
