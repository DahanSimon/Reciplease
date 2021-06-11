//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController {

    var recipeList: [Recipe]?
    
    var ingredientsList: [String]? {
        if let recipe = selectedRecipe {
            return recipe.ingredients
        }
        return nil
    }

    var recipeIndex = 0
    var selectedRecipe: Recipe? {
        if let recipeList = recipeList {
            return recipeList[recipeIndex]
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let imageUrl =  selectedRecipe?.imageUrl, let url = URL(string: imageUrl) else {
            return
        }
        let isLiked = RecipeCoreData.all.contains(where: { recipe in
            if recipe.name == selectedRecipe?.name {
                return true
            }
            return false
        })
        likedButton.isSelected = isLiked
        self.recipeImage.load(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        configure(recipe: selectedRecipe)
    }
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        if let recipe = selectedRecipe, let directionsUrl = recipe.directionUrl, let url = URL(string: directionsUrl) {
            showDirections(url: url)
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likedButton.isSelected = !likedButton.isSelected
        let isLiked = RecipeCoreData.all.contains(where: { recipe in
            if recipe.name == selectedRecipe?.name {
                return true
            }
            return false
        })
        if isLiked, let likedRecipe = selectedRecipe, let uri = likedRecipe.uri {
            removeRecipe(uri: uri)
            return
        }
        
        guard let selectedRecipe = selectedRecipe else {
            return
        }
        saveRecipe(likedRecipe: selectedRecipe)
    }
    
    private func configure(recipe: Recipe?) {
        self.recipeTitle.text = recipe?.name
    }
    
    private func showDirections(url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
}

extension RecipeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = self.ingredientsList?.count else {
            return 0
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }
        guard let ingredient = self.ingredientsList?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = ingredient
        return cell
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
