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
        
        viewControllers = [searchVC]
        print("commit")
        
    }
    
    
    
  

}

