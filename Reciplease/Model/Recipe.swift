//
//  Recipe.swift
//  Reciplease
//
//  Created by Simon Dahan on 09/06/2021.
//

import Foundation


class Recipe {
    let name: String?
    let imageUrl: String?
    let directionUrl: String?
    let totalTime: Int?
    let yield: Int?
    let ingredients: [String]?
    
    init(apiRecipe: ApiRecipe?, coreDataRecipe: RecipeCoreData?) {
        if let recipe = apiRecipe {
            self.name = recipe.label
            self.imageUrl = recipe.image
            self.directionUrl = recipe.url
            self.totalTime = recipe.totalTime
            self.yield = recipe.yield
            self.ingredients = recipe.ingredientLines
        } else {
            let recipe = coreDataRecipe
            self.name = recipe?.name
            self.imageUrl = recipe?.image
            self.directionUrl = recipe?.url
            self.totalTime = Int(recipe!.totalTime)
            self.yield = Int(recipe!.yield)
            let ingredientsArray = recipe?.ingredients?.components(separatedBy: ",") //split(separator: ",")
            self.ingredients = ingredientsArray
        }
    }
}
