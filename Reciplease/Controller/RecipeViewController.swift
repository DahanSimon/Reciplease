//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit

class RecipeViewController: UIViewController {

    var recipeList: [Recipe] = Recipe.all
    var recipeIndex = 0
    var selectedRecipe: Recipe {
        let recipe = recipeList[recipeIndex]
        recipe.ingredientList = [Ingredient(named: "Tomato Sauce"), Ingredient(named: "Cheese"), Ingredient(named: "Pizza Dough")]
        return recipe
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        if selectedRecipe.isLiked {
            likedButton.isSelected = true
        }
        configure(recipe: selectedRecipe)
    }
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if selectedRecipe.isLiked {
            self.selectedRecipe.isLiked = false
            likedButton.isSelected = false
        } else {
            self.selectedRecipe.isLiked = true
            likedButton.isSelected = true
        }
        try? AppDelegate.viewContext.save()
    }
    
    private func configure(recipe: Recipe) {
        self.recipeImage.image = UIImage(named: recipe.imageName ?? "Pizza")
        self.recipeTitle.text = recipe.name
    }
}

extension RecipeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedRecipe.ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = selectedRecipe.ingredientList[indexPath.row].name
        return cell
    }
}
