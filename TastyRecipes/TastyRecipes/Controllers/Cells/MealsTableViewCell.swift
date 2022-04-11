//
//  MealsTableViewCell.swift
//  TastyRecipes
//
//  Created by user203528 on 3/30/22.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var mealsImageView: UIImageView!
    @IBOutlet weak var mealsTitleLabel: UILabel!
}
