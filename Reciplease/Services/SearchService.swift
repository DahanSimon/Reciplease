//
//  SearchService.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation
import Alamofire

class SearchService: RecipeSearchProtocol {
    // Change this value to the desired amount of recipe to load
    private let numberOfRecipesToLoad: String = "20"
    var ingredients: [String] = []
    func getRecipes(ingredients: [String], callback: @escaping (Result<[Recipe], SearchErrors>) -> Void) {
        self.ingredients = ingredients
        AF.request(requestUrl).response { response in
            DispatchQueue.main.async {
                guard let data =  response.data else {
                    callback(Result.failure(SearchErrors.apiError))
                    return
                }
                if let responseJSON = try? JSONDecoder().decode(RecipeList.self, from: data) {
                    var recipes: [Recipe] = []
                    for apiRecipe in responseJSON.hits {
                        let recipe = Recipe(apiRecipe: apiRecipe.recipe, coreDataRecipe: nil)
                        recipes.append(recipe)
                    }
                    callback(Result.success(recipes))
                } else {
                    callback(Result.failure(SearchErrors.apiError))
                }
            }
        }
    }
    private var requestUrl: URL {
        guard let ingredientsString = self.ingredients.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return URL(string: "")! }
        let url = URL(string: "https://api.edamam.com/search" +
                      "?q=" + ingredientsString + "&app_id=d1ea0569&from=0&to=\(numberOfRecipesToLoad)&app_key=d242706587ab1a0de5418308397af347")!
        return url
    }
}

enum SearchErrors: Error {
    case apiError
    case noRecipeFound
}
