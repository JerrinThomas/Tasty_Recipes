//
//   Requests.swift
//  SearchTabbar
//
//  Created by user204823 on 3/23/22.
//

import Foundation

class Requests {
    
    static let searchMealsByNameURL = "https://www.themealdb.com/api/json/v1/1/search.php?s="
    static let searchMealsByFirstLetterURL = "https://www.themealdb.com/api/json/v1/1/search.php?f="
    static let searchRandomMeal = "https://www.themealdb.com/api/json/v1/1/random.php"
    static let getAllCategoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    static let getMealsByCategoryURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    static let getMealByIdURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    
    static func getSearchResult(name:String,completionHandler: @escaping (_ results: [DetailedMeal]) -> Void){
        
        let url:URL
        
        if(name.count == 1){
            url = URL(string: searchMealsByFirstLetterURL + name)!
        }
        else{
            url = URL(string: searchMealsByNameURL + name)!
        }
        
        URLSession.shared.dataTask(with: url){
            (data,response,error) in
            guard let data = data else {return}
            var results:[DetailedMeal] = []
            if let decodedResponse = try? JSONDecoder().decode(ListOfDetailedMeals.self, from: data) {
                results = decodedResponse.meals
            } else{
                results = []
            }
            completionHandler(results)
        }.resume()
    }
    
    static func randomMeal(completionHandler: @escaping (_ results: [DetailedMeal]) -> Void){
        URLSession.shared.dataTask(with: URL(string: searchRandomMeal)!){
            (data,response,error) in
            guard let data = data else {return}
            var results:[DetailedMeal] = []
            if let decodedResponse = try? JSONDecoder().decode(ListOfDetailedMeals.self, from: data) {
                results = decodedResponse.meals
            } else{
                results = []
            }
            completionHandler(results)
        }.resume()
    }
    
    static func getAllCategories(completionHandler: @escaping (_ results: [Category]) -> Void){
        URLSession.shared.dataTask(with: URL(string: getAllCategoriesURL)!) {
            (data,response,error) in
            guard let data = data else {return}
            
            var categories:[Category] = []
            
            if let decodedResponse = try? JSONDecoder().decode(ListOfCategories.self, from: data){
                categories = decodedResponse.categories
            }
            
            completionHandler(categories)
        }.resume()
    }
    
    static func getMealsByCategory(category:String, completionHandler: @escaping (_ results: [SimpleMeal]) -> Void){
        URLSession.shared.dataTask(with: URL(string: getMealsByCategoryURL)!) {
            (data,response,error) in
            guard let data = data else {return}
            
            var meals:[SimpleMeal] = []
            
            if let decodedResponse = try? JSONDecoder().decode(ListOfSimpleMeals.self, from: data){
                meals = decodedResponse.meals
            }
            
            completionHandler(meals)
        }.resume()
    }
    
    static func getMealById(id:String, completionHandler: @escaping (_ results: [DetailedMeal]) -> Void){
        URLSession.shared.dataTask(with: URL(string: getMealByIdURL)!) {
            (data,response,error) in
            guard let data = data else {return}
            
            var meals:[DetailedMeal] = []
            
            if let decodedResponse = try? JSONDecoder().decode(ListOfDetailedMeals.self, from: data){
                meals = decodedResponse.meals
            }
            
            completionHandler(meals)
        }.resume()
    }
    
}
