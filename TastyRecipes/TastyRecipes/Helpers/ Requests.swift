//
//   Requests.swift
//  SearchTabbar
//
//  Created by user204823 on 3/23/22.
//

import Foundation

class Requests {
    
    static func getSearchResult(name:String,completionHandler: @escaping (_ results: Searches) -> Void){
        
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
            
            do{
                                
                let decoder = JSONDecoder()
                
                guard let searches = try? decoder.decode(Searches.self, from: data) else {
                    return
                }
                
                completionHandler(searches)
            }
            catch{
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
        
    
    
    static func randomMeal(completionHandler: @escaping (_ results: Searches) -> Void){
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        
        let task = URLSession.shared.dataTask(with: url){
            (data,response,error) in
            
            guard let data = data else {return}

            let decoder = JSONDecoder()
                
            guard let searches = try? decoder.decode(Searches.self, from: data) else {
                    return
            }
            completionHandler(searches)
        }.resume()
    }
    
    
}
