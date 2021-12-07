//
//  RecipeListCell.swift
//  Reciplease
//
//  Created by Simon Dahan on 26/05/2021.
//

import UIKit

class RecipeListCell: UITableViewCell {
    @IBOutlet weak var recipeListView: UIView!
    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.recipeListView.layer.cornerRadius = 10
        self.textLabel?.textAlignment = .center
        self.textLabel?.font = UIFont(name: "Montserrat", size: 18)
        addShadow()
    }
    private func addShadow() {
        recipeListView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        recipeListView.layer.shadowRadius = 2.0
        recipeListView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        recipeListView.layer.shadowOpacity = 2.0
    }
    func configure(name: String, description: String, duration: Int, imageUrl: URL) {
        recipeDescription.text = description
        recipeTitle.text = name
        if duration > 0 {
            timeLabel.isHidden = false
            timeLabel.text = String(duration) + " minutes"
        } else {
            timeLabel.isHidden = true
        }
        recipePicture.load(url: imageUrl)
    }
}
