//
//  Favorite.swift
//  TastyRecipes
//
//  Created by Suelen Vicente on 2022-03-31.
//

import Foundation
import FirebaseFirestoreSwift

struct Favorite: Codable{
    @DocumentID var documentId: String?
    var user: String
    var category: String
    var mealId: String
}
