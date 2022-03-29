//
//  ViewController.swift
//  SearchTabbar
//
//  Created by user204823 on 3/22/22.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())        
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 0)
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "starIcon"), tag: 1)
        
        viewControllers = [searchVC, favoritesVC]
        print("hi")
        
    }
    
    
    
  

}

