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
    
    @IBOutlet weak var AddToFavButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(mealRecipe == nil || loggedUser == ""){
            dismiss(animated: true, completion: nil)
        }

        navigationItem.title = mealRecipe?.strMeal
        displayRecipeDetails()
        
    }
    
    func displayRecipeDetails(){
        let imageThumbURL = mealRecipe?.strMealThumb
        recipeThumbImageView.loadFrom(URLAddress: imageThumbURL ?? defaultMealImage)
        //recipeThumbImageView.layer.cornerRadius = 20
        
        recipeDetailLabel.text = mealRecipe?.strInstructions
              
        recipeDetailLabel.textAlignment = .center
        recipeDetailLabel.font = UIFont.systemFont(ofSize: 14)
        recipeDetailLabel.contentMode = .scaleToFill
        recipeDetailLabel.numberOfLines = 0
    }
    
    @IBAction func touchUpInsideAddToFavButton(_ sender: Any) {
        // add favorite to the FireStore
//        let favorite = Favorite(documentId: nil, user: self.loggedUser, category: mealRecipe?.strCategory, mealId: mealRecipe?.idMeal)
//        Persistence.addFavorite(favorite: favorite)
    }
    

}
