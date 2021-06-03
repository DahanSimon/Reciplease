//
//  SearchService.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

class Search {
    static var recipeList: RecipeList? = nil
    var api: RecipeSearchProtocol
    
    init(api: RecipeSearchProtocol) {
        self.api = api
    }
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<RecipeList?, SearchErrors>) -> Void) {
        api.getRecipes(ingredients: ingredients) { recipeList in
            Search.recipeList = nil
            switch recipeList {
            
            case .success(let success):
                Search.recipeList = success
            case .failure(_):
                break
            }
            callback(recipeList)
        }
    }
}
