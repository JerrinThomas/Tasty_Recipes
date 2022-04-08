//
//  FavoriteMealsViewController.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-27.
//

import Foundation
import UIKit

class FavoriteMealViewController: UITableViewController{
    
    let defaultMealImage: String = "https://www.themealdb.com/images/category/beef.png"
    
    var meals: [DetailedMeal] = []
    var category: String = ""
    var loggedUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(category == "" || loggedUser == ""){
            dismiss(animated: true, completion: nil)
        }
        
        getFavoritesByCategory()
        
        tableView.rowHeight = 200
        
        //title at the top of the page
        navigationItem.title = "Favorite Meals"
        
       tableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: "MealTableViewCell")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        
        let mealTitle = meals[indexPath.row].strMeal
        let imageURL = meals[indexPath.row].strMealThumb
        
        categoryCell.mealTitleLabel.text = mealTitle
        categoryCell.mealThumbImageView.loadFrom(URLAddress: imageURL ?? defaultMealImage)
        
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //open the meal page
        print("Open Meal Page HERE")
        let recipeVC = RecipeViewController()
        recipeVC.mealRecipe = meals[indexPath.row]
        recipeVC.loggedUser = self.loggedUser
        navigationController?.pushViewController(recipeVC, animated: true)
        
    }
    
    func getFavoritesByCategory(){
        Persistence.getFavoritesMealsIdByUserAndCategory(loggedUser: self.loggedUser, category: self.category, completionHandler: { (mealsId, error) in
          
            for mealId in mealsId{
                Requests.getMealById(id: mealId, completionHandler:{ results in
                    
                    self.meals.append(contentsOf: results)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        })
    }
}
