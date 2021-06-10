//
//  SearchService.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//

import Foundation

class SearchService: RecipeSearchProtocol {
    private let numberOfRecipesToLoad: String = "20"
    private var task: URLSessionDataTask?
    private var searchSession = URLSession(configuration: .default)
    var ingredients: [String] = []
    func getRecipes(ingredients: [String], callback: @escaping (Result<RecipeList?, SearchErrors>) -> Void) {
        self.ingredients = ingredients
        let request = createRequest()
        task?.cancel()
        task = searchSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { 
                guard let data = data, error == nil else {
                    callback(Result.failure(SearchErrors.apiError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(Result.failure(SearchErrors.apiError))
                    return
                }
                
                if let responseJSON = try? JSONDecoder().decode(RecipeList.self, from: data) {
                    callback(Result.success(responseJSON))
                } else {
                    callback(Result.failure(SearchErrors.apiError))
                }
            }
        }
        task?.resume()
    }
    
    private var requestUrl: URL {
        guard let ingredientsString = self.ingredients.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return URL(string: "")! }
        let url = URL(string: "https://api.edamam.com/search" + "?q=" + ingredientsString + "&app_id=d1ea0569&from=0&to=\(numberOfRecipesToLoad)&app_key=d242706587ab1a0de5418308397af347")!
        return url
    }
    
    private func createRequest() -> URLRequest {
        var request = URLRequest(url: self.requestUrl)
        request.httpMethod = "POST"
        
        let body = ""
        request.httpBody = body.data(using: .utf8)
        return request
    }
}


enum SearchErrors: Error {
    case apiError
}
