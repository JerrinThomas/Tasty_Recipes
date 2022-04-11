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
    
    var isMealFavorite = false
    
    var mealCategory = ""
    
    var mealId = ""
    
    var favMeals: [DetailedMeal] = []
    
    let defaultMealImage: String = "https://www.themealdb.com/images/category/beef.png"
    
    @IBOutlet weak var recipeThumbImageView: UIImageView!
    
    @IBOutlet weak var recipeDetailLabel: UILabel!
    
    @IBOutlet weak var AddToFavButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if(mealRecipe == nil){
            getMealById()
        }else{
            mealCategory = mealRecipe?.strCategory ?? ""
            mealId = mealRecipe?.idMeal ?? ""
            
            displayRecipeDetails()
        }
        
        navigationItem.title = mealRecipe?.strMeal
        
        processFavoriteButton()
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
    
    func processFavoriteButton(){
        Persistence.getFavoritesMealsIdByUserAndCategory(loggedUser: self.loggedUser, category: self.mealCategory, completionHandler: { (mealsId, error) in
          
            for mealId in mealsId{
                Requests.getMealById(id: mealId, completionHandler:{ results in
                    
                    self.favMeals.append(contentsOf: results)
                    
                    DispatchQueue.main.async {
                        print(self.favMeals.count)
                        for favMeal in self.favMeals {
                            if(favMeal.idMeal == self.mealId && favMeal.strCategory == self.mealCategory){
                                self.AddToFavButton.setTitle("Favorited", for: .normal)
                                self.AddToFavButton.backgroundColor = UIColor.green
                                self.isMealFavorite = true
                            }
                        }
                    }
                    })
            }
        })
    }
    
    func getMealById(){
        Requests.getMealById(id: self.mealId, completionHandler:{ results in
            self.mealRecipe = results[0]
            self.mealCategory = results[0].strCategory!
            
            DispatchQueue.main.async {
                self.displayRecipeDetails()
            }
        })
    }
    
    @IBAction func touchUpInsideAddToFavButton(_ sender: Any) {
        // add favorite to the FireStore
        
        let favorite = Favorite(documentId: nil, user: self.loggedUser, category: self.mealCategory, mealId: self.mealId)
        Persistence.addFavorite(favorite: favorite)
        self.processFavoriteButton()
    }
}
