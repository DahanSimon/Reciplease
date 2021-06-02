//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 25/05/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findButton: CustomUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        findButton.isHidden = true
        resetAllRecords(in: "Recipe")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displaySearchButton()
    }
    
    var recipeList: RecipeList?
    var ingredients: [Ingredient2] = []
    
    
    private func createRecipe() {
//        let recipe = Recipe(context: AppDelegate.viewContext)
//        recipe.likes = 500
//        recipe.name = "Pizza"
//        recipe.recipeDescription = "Tomato Sauce, Cheese, Basil."
//        recipe.imageName = "pizza"
//        let recipe2 = Recipe(context: AppDelegate.viewContext)
//        recipe2.likes = 1000
//        recipe2.name = "Pasta"
//        recipe2.recipeDescription = "Tomato Sauce, Cheese."
//        recipe2.imageName = "pasta"
        
        let ingredientName: String = "Tomato"
        let recipe = ApiRecipe(label: "Pizza", image: "https://www.edamam.com/web-img/fd6/fd6fc1464f324b25f16e24688da668f5.jpg", url: "https://www.example.com", yield: 2,  ingredientLines: ["250gr Pizza Dough", "100gr Tomato Sacue", "100gr Mozzarella"], ingredients: [Ingredient(text: "Pizza Dough", weight: 255.0), Ingredient(text: "Tomato Sauce", weight: 100.0), Ingredient(text: "Mozzarella", weight: 100.0)])
        let founds = Founds(recipe: recipe)
        self.recipeList = RecipeList(q: ingredientName, from: 0, to: 5, more: false, count: 1, hits: [founds])
//        try? AppDelegate.viewContext.save()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "findSegue"{
            let recipeVC = segue.destination as? RecipeListViewController
            recipeVC?.recipeList = recipeList!.hits
        }
    }
    
    @IBAction func findRecipe(_ sender: Any) {
        createRecipe()
        
        self.ingredients = []
        tableView.reloadData()

    }
    
    private func displaySearchButton() {
        if ingredients.count < 2 {
            findButton.isHidden = true
        } else {
            findButton.isHidden = false
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }
        
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        guard let ingredientName = searchTextField.text else {
            return true
        }
        
        let newIngredient = Ingredient2(named: ingredientName)
        ingredients.append(newIngredient)
        tableView.reloadData()

        displaySearchButton()
        return true
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}
