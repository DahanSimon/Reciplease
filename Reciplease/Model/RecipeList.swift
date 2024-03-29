//
//  RecipeList.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

// MARK: - RecipeList
struct RecipeList: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Founds]
}

// MARK: - Hit
struct Founds: Codable {
    var recipe: ApiRecipe
}

// MARK: - Recipe
struct ApiRecipe: Codable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double

    enum CodingKeys: String, CodingKey {
        case text, weight
    }
}
