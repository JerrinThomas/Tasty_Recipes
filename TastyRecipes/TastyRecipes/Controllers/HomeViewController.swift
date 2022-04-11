//
//  HomeViewController.swift
//  TastyRecipes
//
//  Created by user203528 on 3/29/22.
//
import Foundation
import UIKit

class HomeViewController: UITableViewController {
        
    let defaultCategoryImage: String = "https://www.themealdb.com/images/category/beef.png"
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategories()
        
        tableView.rowHeight = 88
        
        //title at the top of the page
        navigationItem.title = "Categories"
        
       tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        
        let imageURL = categories[indexPath.row].strCategoryThumb
        //print (categoryName)
        categoryCell.categoryNameLabel.text = categories[indexPath.row].strCategory
        categoryCell.categoryDescriptionLabel.text = categories[indexPath.row].strCategoryDescription
        categoryCell.categoryImageView.loadFrom(URLAddress: imageURL ?? defaultCategoryImage)
        
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    //to be updated
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row].strCategory
        
        let MealsVC = MealsTableViewController()
        
        MealsVC.category = category ?? ""
        
        navigationController?.pushViewController(MealsVC, animated: true)
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
