//
//  MealsTableViewController.swift
//  TastyRecipes
//
//  Created by user203528 on 3/30/22.
//

import UIKit

class MealsTableViewController: UITableViewController {
        
    let defaultMealImage: String = "https://www.themealdb.com/images/category/beef.png"
    
    var meals: [SimpleMeal] = []
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if category == ""{
            dismiss(animated: true, completion: nil)
        }
        
        getMeals()
        
        tableView.rowHeight = 80
        
        //title at the top of the page
        navigationItem.title = "Selected Category Meals"
        
       tableView.register(UINib(nibName: "MealsTableViewCell", bundle: nil), forCellReuseIdentifier: "MealsTableViewCell")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "MealsTableViewCell", for: indexPath) as! MealsTableViewCell
        
        let mealTitle = meals[indexPath.row].strMeal
        let imageURL = meals[indexPath.row].strMealThumb
        
        categoryCell.mealsTitleLabel.text = mealTitle
        categoryCell.mealsImageView.loadFrom(URLAddress: imageURL ?? defaultMealImage)
        
        return categoryCell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
