//
//  RecipeViewController.swift
//  TastyRecipes
//
//  Created by Jerrin Thomas on 4/7/22.
//

import UIKit
import TagListView

class RecipeViewController: UIViewController {
    
    var mealRecipe: DetailedMeal? = nil
    	
    var loggedUser: String = ""
    
    let defaultMealImage: String = "https://www.themealdb.com/images/category/beef.png"
    
    @IBOutlet weak var recipeThumbImageView: UIImageView!
    
    @IBOutlet weak var recipeDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = mealRecipe?.strMeal
        displayRecipeDetails()
        
    }
    
    func displayRecipeDetails(){
        let imageThumbURL = mealRecipe?.strMealThumb
        recipeThumbImageView.loadFrom(URLAddress: imageThumbURL ?? defaultMealImage)
        
        recipeDetailLabel.text = mealRecipe?.strInstructions
              
        recipeDetailLabel.textAlignment = .center
        recipeDetailLabel.font = UIFont.systemFont(ofSize: 14)
        recipeDetailLabel.contentMode = .scaleToFill
        recipeDetailLabel.numberOfLines = 0
//        recipeDetailLabel.heightAncho
//        recipeDetailLabel.margin
//        recipeDetailLabel.frame = CGRect(x:10,y:300,width:view.bounds.width - 64,height:view.bounds.height - 64)
    }
    
    

}
