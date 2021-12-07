//
//  CustomUIButton.swift
//  Reciplease
//
//  Created by Simon Dahan on 25/05/2021.
//

import UIKit

class CustomUIButton: UIButton {
    var cornerRadius: CGFloat = 10
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        self.layer.shadowOpacity = 2.0
    }
}
