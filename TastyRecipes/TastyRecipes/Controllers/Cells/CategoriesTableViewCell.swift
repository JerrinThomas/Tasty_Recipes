//
//  CategoriesTableViewCell.swift
//  TastyRecipes
//
//  Created by user203528 on 3/30/22.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
}
