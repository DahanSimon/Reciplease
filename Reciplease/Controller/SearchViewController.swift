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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displaySearchButton()
    }
    
    var ingredients: [Ingredient] = []
    
    
    private func createRecipe() {
        let recipe = Recipe(context: AppDelegate.viewContext)
        recipe.likes = 500
        recipe.name = "Pizza"
        recipe.recipeDescription = "Tomato Sauce, Cheese, Basil."
        try? AppDelegate.viewContext.save()
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
        
        let newIngredient = Ingredient(named: ingredientName)
        ingredients.append(newIngredient)
        tableView.reloadData()

        displaySearchButton()
        return true
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}
