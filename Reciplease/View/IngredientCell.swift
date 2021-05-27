//
//  IngredientListTableViewCell.swift
//  Reciplease
//
//  Created by Simon Dahan on 25/05/2021.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.textAlignment = .center
        self.textLabel?.font = UIFont(name: "Montserrat", size: 18)
        addShadow()
    }
    
    private func addShadow() {
        customView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        customView.layer.shadowRadius = 2.0
        customView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        customView.layer.shadowOpacity = 2.0
    }
    
}
