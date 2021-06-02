//
//  recipeSearchProtocol.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

protocol RecipeSearchProtocol {
    func getRecipes(callback: @escaping (Result<RecipeList?, Error>) -> Void)
}
