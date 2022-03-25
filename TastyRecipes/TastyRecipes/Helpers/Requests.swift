//
//   Requests.swift
//  SearchTabbar
//
//  Created by user204823 on 3/23/22.
//

import Foundation

class Requests {
    
    static func getSearchResult(name:String,completionHandler: @escaping (_ results: [Search]) -> Void){
        
        let url:URL
        
        if(name.count == 1){
            url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?f="+name)!
        }
        else{
            url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s="+name)!
        }
        
        let task = URLSession.shared.dataTask(with: url){
            (data,response,error) in
            guard let data = data else {return}
            var results:[Search] = []
            if let decodedResponse = try? JSONDecoder().decode(Searches.self, from: data) {
                results = decodedResponse.meals
            } else{
                results = []
            }
            completionHandler(results)
        }.resume()
    }
        
    
    
    static func randomMeal(completionHandler: @escaping (_ results: [Search]) -> Void){
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        
        let task = URLSession.shared.dataTask(with: url){
            (data,response,error) in
            guard let data = data else {return}
            var results:[Search] = []
            if let decodedResponse = try? JSONDecoder().decode(Searches.self, from: data) {
                results = decodedResponse.meals
            } else{
                results = []
            }
            completionHandler(results)
        }.resume()
    }
    
    
}
