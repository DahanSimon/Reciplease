//
//  recipeSearchProtocol.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

protocol RecipeSearchProtocol {
    func getRecipes(ingredients: [String], callback: @escaping (Result<[Recipe], SearchErrors>) -> Void)
}
