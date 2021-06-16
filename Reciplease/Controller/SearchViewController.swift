//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 25/05/2021.
//

import UIKit

class SearchViewController: UIViewController {
    var search: Search = Search(api: SearchService())
    var ingredients: [String] = []
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var findButton: CustomUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        findButton.isHidden = true
//        resetAllRecords(in: "RecipeCoreData")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displaySearchButton()
        activityIndicator.isHidden = true
    }
    
    @IBAction func findRecipe(_ sender: Any) {
        getRecipes()
        resetView()
    }
    
    func resetView() {
        self.ingredients = []
        self.searchTextField.text = ""
        findButton.isHidden = true
        activityIndicator.isHidden = true
        tableView.reloadData()
    }
    
    fileprivate func getRecipes() {
        activityIndicator.isHidden = false
        findButton.isHidden = true
        search.getRecipes(ingredients: self.ingredients, callback: { result  in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.performSegue(withIdentifier: "findSegue", sender: nil)
                case .failure(let error):
                    switch error {
                    case .apiError:
                        self.presentAlert(message: "An error occured please try again")
                    case .noRecipeFound:
                        self.presentAlert(message: "Sorry no recipes founded for these ingredients. \n Maybe you should go shopping !")
                    }
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
