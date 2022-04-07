//
//  FavoritesViewController.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-25.
//

import Foundation
import UIKit
import FirebaseAuth

class FavoritesViewController: UITableViewController{
    
    let defaultCategoryImage: String = "https://www.themealdb.com/images/category/beef.png"
    
    var categories: [Category] = []
    var allCategories: [Category] = []
    
    var user: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        user = (Auth.auth().currentUser?.uid)!
        
        getAllCategories()

        getAllFavoritesCategory()
        
        tableView.rowHeight = 80
        
        //title at the top of the page
        navigationItem.title = "Favorites Categories"
        
        //add test
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavoriteTest))
        
        //reload table
        tableView.reloadData()
       
       tableView.register(UINib(nibName: "FavCategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavCategoriesTableViewCell")
    }
    
    @objc
    func addFavoriteTest() {
        Requests.randomMeal { results in
            let categoryStr = results.first?.strCategory ?? ""
            let mealId = results.first?.idMeal ?? ""
            
            // add favorite to the FireStore
            let favorite = Favorite(documentId: nil, user: self.user, category: categoryStr, mealId: mealId)
            Persistence.addFavorite(favorite: favorite)
            
            let category = self.allCategories.filter {
                $0.strCategory == categoryStr
            }.first
            
            let duplicatedCategory = self.categories.filter { $0.strCategory == categoryStr }
            
            if(duplicatedCategory.isEmpty){
                self.categories.append(category!)
            }
            
            print("meal added.")
            print("category => \(categoryStr)")
            print("mealId => \(mealId)")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "FavCategoriesTableViewCell", for: indexPath) as! FavCategoriesTableViewCell
        
        let categoryName = categories[indexPath.row].strCategory
        let imageURL = categories[indexPath.row].strCategoryThumb
        
        categoryCell.categoryNameLabel.text = categoryName
        categoryCell.categoryThumbImageView.loadFrom(URLAddress: imageURL ?? defaultCategoryImage)
        
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row].strCategory
        
        let favMealsVC = FavoriteMealViewController()
        
        favMealsVC.category = category ?? ""
        favMealsVC.loggedUser = self.user
        
        navigationController?.pushViewController(favMealsVC, animated: true)
    }
    
    func getAllCategories(){
        
        Requests.getAllCategories(completionHandler: { (results) in
            self.allCategories.append(contentsOf: results)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func getAllFavoritesCategory(){
        
        Persistence.getFavoritesByUser(loggedUser: user, completionHandler: { (favs, error) in
            for fav in favs{
                let category = self.allCategories.filter {
                    $0.strCategory == fav.category
                }.first
                
                let duplicatedCategory = self.categories.filter { $0.strCategory == category?.strCategory }
                
                if(duplicatedCategory.isEmpty){
                    self.categories.append(category!)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
    }
    
}

