//
//  MealTableViewCell.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-27.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var mealThumbImageView: UIImageView!
    
    @IBOutlet weak var mealTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
