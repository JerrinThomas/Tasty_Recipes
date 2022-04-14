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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        //title at the top of the page
        navigationItem.title = "Favorites Categories"
        
        tableView.register(UINib(nibName: "FavCategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavCategoriesTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        user = (Auth.auth().currentUser?.uid)!
        categories = []
        
        getAllCategories()
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
        
        let favMealsVC = FavoriteMealsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        favMealsVC.category = category ?? ""
        favMealsVC.loggedUser = self.user
        
        navigationController?.pushViewController(favMealsVC, animated: true)
    }
    
    func getAllCategories(){
        
        Requests.getAllCategories(completionHandler: { (results) in
            self.allCategories.append(contentsOf: results)
            
            DispatchQueue.main.async {
                if(self.allCategories.count > 1){
                    self.allCategories = self.allCategories.sorted(by: { $0.strCategory! < $1.strCategory! })
                }
                
                self.getAllFavoritesCategory()
            }
        })
    }
    
    func getAllFavoritesCategory(){
        
        Persistence.getFavoritesByUser(loggedUser: user, completionHandler: { (favs, error) in
            let sortedFavs = favs.sorted(by: { $0.category < $1.category })
            
            for fav in sortedFavs{
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

