//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController {
    let coreDataTask = RecipeCoreData.coreDataStack
    let coreDataService = CoreDataService(managedObjectContext: RecipeCoreData.coreDataStack.mainContext, coreDataStack: RecipeCoreData.coreDataStack)
    var selectedRecipe: Recipe?
    var ingredientsList: [String]? {
        if let recipe = selectedRecipe {
            return recipe.ingredients
        }
        return nil
    }
    var isLiked: Bool {
        return RecipeCoreData.all.contains(where: { recipe in
            if recipe.uri == selectedRecipe?.uri {
                return true
            }
            return false
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let imageUrl =  selectedRecipe?.imageUrl, let url = URL(string: imageUrl) else {
            return
        }
        
        likedButton.isSelected = isLiked
        self.recipeImage.load(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        self.recipeTitle.text = selectedRecipe?.name
    }
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        if let recipe = selectedRecipe, let directionsUrl = recipe.directionUrl, let url = URL(string: directionsUrl) {
            showDirections(url: url)
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likedButton.isSelected = !likedButton.isSelected
        guard let selectedRecipe = selectedRecipe else {
            return
        }
        
        if isLiked, let uri = selectedRecipe.uri {
            let removed = coreDataService.removeRecipe(uri: uri)
            if removed == false {
                presentAlert(message: "Sorry an error occured. Please try again")
            }
        } else {
            let saved = coreDataService.saveRecipe(likedRecipe: selectedRecipe, coreDataTask: coreDataTask)
            if saved == false {
                presentAlert(message: "Sorry an error occured. Please try again")
            }
        }
    }
    private func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    private func showDirections(url: URL) {
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
        guard let numberOfRows = self.ingredientsList?.count else {
            return 0
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }
        guard let ingredient = self.ingredientsList?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = ingredient
        return cell
    }
}

extension UIImageView {
    
    // This method download an image from an URL
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
