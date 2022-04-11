//
//  FavoriteMealsCollectionViewController.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-04-10.
//

import UIKit

private let reuseIdentifier = "FavoriteMealCollectionViewCell"

class FavoriteMealsCollectionViewController: UICollectionViewController {
    
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
        
        //title at the top of the page
        navigationItem.title = "Favorite Meals"

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "FavoriteMealCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.itemSize = CGSize(width: 200, height: 200)
                }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteMealCollectionViewCell
    
        let mealTitle = meals[indexPath.row].strMeal
        let imageURL = meals[indexPath.row].strMealThumb
        
        cell.mealTitleLabel.text = mealTitle
        cell.mealImage.loadFrom(URLAddress: imageURL ?? defaultMealImage)
        cell.mealImage.layer.cornerRadius = 20
        cell.mealImage.clipsToBounds = true
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //open the meal page
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
                        self.collectionView.reloadData()
                    }
                })
            }
        })
    }
    
}
