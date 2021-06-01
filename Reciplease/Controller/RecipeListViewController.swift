//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit



class RecipeListViewController: UIViewController {
    var recipeList: [Recipe] = Recipe.all
    var selectedRowIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailsSegue"{
            let recipeVC = segue.destination as? RecipeViewController
            recipeVC?.recipeIndex = self.selectedRowIndex
        }
    }
}

extension RecipeListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListCell else {
            return UITableViewCell()
        }
        
        let recipe = recipeList[indexPath.row]
        cell.configure(name: recipe.name!, description: recipe.recipeDescription!, likes: Int(recipe.likes), imageName: "pizza")
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
    }
}
