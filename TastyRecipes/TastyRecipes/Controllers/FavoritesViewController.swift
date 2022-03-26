//
//  FavoritesViewController.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var categoriesArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func testbtn(_ sender: Any) {
        getAllCategories()
    }
    
    func getAllCategories() {
        Requests.getAllCategories(completionHandler: { results in
            self.categoriesArray = results
        })
        
        for category in categoriesArray {
            print("id: " + category.idCategory!)
            print("str: " + category.strCategory!)
        }
    }
    
    

}
