//
//  FavoritesViewController.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-25.
//

import Foundation
import UIKit

class FavoritesViewController: UITableViewController{
    
    let defaultCategoryImage: String = "https://www.themealdb.com/images/category/beef.png"
    var categories: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategories()
        
        tableView.rowHeight = 80
        
        //title at the top of the page
        navigationItem.title = "Favorites Categories"
        
       tableView.register(UINib(nibName: "FavCategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavCategoriesTableViewCell")
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
        
        navigationController?.pushViewController(favMealsVC, animated: true)
    }
    
    func getCategories() {
        categories = []
        
        Requests.getAllCategories(completionHandler: { (results) in
            
            self.categories.append(contentsOf: results)
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        })
    }
    
}

