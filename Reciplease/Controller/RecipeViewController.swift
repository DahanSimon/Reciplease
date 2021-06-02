//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController {

    var recipeList: [Founds] = []
    var ingredientList: [String] = []
    var recipeIndex = 0
    var selectedRecipe: ApiRecipe {
        let recipe = recipeList[recipeIndex].recipe
        return recipe
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        self.ingredientList = self.selectedRecipe.ingredientLines
        if selectedRecipe.isLiked ?? false {
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
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        if let url = URL(string: selectedRecipe.url) {
            showTutorial(url: url)
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
//        if selectedRecipe.isLiked ?? false {
//            self.selectedRecipe.isLiked = false
//            likedButton.isSelected = false
//        } else {
//            self.selectedRecipe.isLiked = true
//            likedButton.isSelected = true
//        }
//        try? AppDelegate.viewContext.save()
    }
    
    private func configure(recipe: ApiRecipe) {
        guard let url = URL(string: recipe.image) else {
            return
        }
        self.recipeImage.load(url: url)
        self.recipeTitle.text = recipe.label
    }
    
    private func showTutorial(url: URL) {
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
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = ingredientList[indexPath.row]
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
