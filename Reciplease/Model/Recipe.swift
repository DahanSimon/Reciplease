//
//  Recipe.swift
//  Reciplease
//
//  Created by Simon Dahan on 09/06/2021.
//

import Foundation

struct Recipe {
    var name: String?
    var imageUrl: String?
    var directionUrl: String?
    var totalTime: Int?
    var yield: Int?
    var ingredients: [String]?
    var uri: String?
    
    init(apiRecipe: ApiRecipe?, coreDataRecipe: RecipeCoreData?) {
        if let recipe = apiRecipe {
            self.uri = recipe.uri
            self.name = recipe.label
            self.imageUrl = recipe.image
            self.directionUrl = recipe.url
            self.totalTime = recipe.totalTime
            self.yield = recipe.yield
            self.ingredients = recipe.ingredientLines
        } else if let recipe = coreDataRecipe {
            self.uri = recipe.uri
            self.name = recipe.name
            self.imageUrl = recipe.image
            self.directionUrl = recipe.url
            self.totalTime = Int(recipe.totalTime)
            self.yield = Int(recipe.yield)
            let ingredientsArray = recipe.ingredients?.components(separatedBy: ",")
            self.ingredients = ingredientsArray
        }
    }
}
