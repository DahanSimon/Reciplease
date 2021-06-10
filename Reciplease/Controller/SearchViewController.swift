//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 25/05/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    var api: SearchService?
    var search: Search?
    var recipeList: RecipeList?
    var ingredients: [String] = []
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findButton: CustomUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api = SearchService()
        self.search = Search(api: api!)
        self.tableView.rowHeight = 70
        findButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displaySearchButton()
    }

    @IBAction func findRecipe(_ sender: Any) {
        getRecipes()
        resetView()
    }
    
    fileprivate func resetView() {
        self.ingredients = []
        self.searchTextField.text = ""
        tableView.reloadData()
    }
    
    fileprivate func getRecipes() {
        search?.getRecipes(ingredients: self.ingredients, callback: { result  in
            DispatchQueue.main.async {
                switch result {
                case .success(let successResult):
                    self.recipeList = successResult
                    for apiRecipe in successResult!.hits {
                        let recipe = Recipe(apiRecipe: apiRecipe.recipe, coreDataRecipe: nil)
                        Search.recipeList.append(recipe)
                    }
                    self.performSegue(withIdentifier: "findSegue", sender: nil)
                case .failure(_):
                    self.presentAlert(message: "An error occured please try again")
                    break
                    
                }
            }
        })
    }
    
    private func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
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
        cell.textLabel?.text = ingredient
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
        
        let newIngredient = ingredientName
        ingredients.append(newIngredient)
        tableView.reloadData()
        
        displaySearchButton()
        return true
    }
    
    private func displaySearchButton() {
        if ingredients.count < 2 {
            findButton.isHidden = true
        } else {
            findButton.isHidden = false
        }
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}
