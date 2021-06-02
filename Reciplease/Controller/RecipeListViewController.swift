//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit



class RecipeListViewController: UIViewController {
    
    var recipeList: [Recipe] {
        var recipes: [Recipe] = []
        let tabBar = self.tabBarController?.tabBar.selectedItem?.tag
        if tabBar == 1 {
            for recipe in Recipe.all {
                if recipe.isLiked {
                    recipes.append(recipe)
                }
            }
            return recipes
        } else {
            return Recipe.all
        }
        
    }
    
    var selectedRowIndex = 0
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailsSegue"{
            let recipeVC = segue.destination as? RecipeViewController
            recipeVC?.recipeIndex = self.selectedRowIndex
            recipeVC?.recipeList = recipeList
        }
    }
    deinit {
        print("deinited")
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
        
        
        cell.configure(name: recipe.name!, description: recipe.recipeDescription!, likes: Int(recipe.likes), imageName: recipe.imageName ?? "Pizza")
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "recipeDetailsSegue", sender: self)
    }
}
