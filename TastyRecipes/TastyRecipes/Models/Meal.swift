//
//  Recipe.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-22.
//

import Foundation
import UIKit

struct Meal{
    var idMeal: Int
    var strMeal: String
    var strCategory: Category
    var strInstructions: String
    var strMealThumb: UIImage
    var ingredients: [Ingredient]
    
}
