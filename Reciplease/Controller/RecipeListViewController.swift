//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit



class RecipeListViewController: UIViewController {
    
    var recipeList: [Founds]? = Search.recipeList?.hits
    
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
    
}

extension RecipeListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListCell else {
            return UITableViewCell()
        }
        let recipe = recipeList?[indexPath.row].recipe
        
        
        cell.configure(name: recipe?.label ?? "nil", description: recipe?.label ?? "nil", likes: 500, imageUrl: URL(string: recipe?.image ?? "pizza")!)
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "recipeDetailsSegue", sender: self)
    }
}
