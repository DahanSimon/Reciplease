//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit

class RecipeListViewController: UIViewController {
    var recipeList: [Recipe]? {
        if tabBarIndex == 0 {
            return Search.recipeList
        } else if tabBarIndex == 1 {
            return RecipeCoreData.all
        }
        return nil
    }
    
    var tabBarIndex = 0
    var selectedRowIndex = 0
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
        if let tabBarTag = self.tabBarController?.tabBar.selectedItem?.tag {
            self.tabBarIndex =  tabBarTag
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailsSegue"{
            let recipeVC = segue.destination as? RecipeViewController
            recipeVC?.selectedRecipe = recipeList?[self.selectedRowIndex]
        }
    }
}

extension RecipeListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = recipeList else {
            return 0
        }
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListCell else {
            return UITableViewCell()
        }        
        return createCell(cell: cell, recipeIndex: indexPath.row)
    }
    
    func createCell(cell: RecipeListCell, recipeIndex: Int) -> RecipeListCell {
        guard let recipe = recipeList?[recipeIndex], let name = recipe.name,
              let totalTime = recipe.totalTime, let imageUrl = recipe.imageUrl else {
            return cell
        }
        
        cell.configure(name: name, description: name, duration: totalTime, imageUrl: URL(string: imageUrl)!)
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "recipeDetailsSegue", sender: self)
    }
}
