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
    
    var meals: [SimpleMeal] = []
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if category == ""{
            dismiss(animated: true, completion: nil)
        }
        
        getMeals()
        
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
    }
    
    func getMeals() {
        meals = []
        
        Requests.getMealsByCategory(category: self.category) { results in
            self.meals.append(contentsOf: results)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
