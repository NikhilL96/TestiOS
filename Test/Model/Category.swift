//
//  Category.swift
//  Test
//
//  Created by Nikhil L on 25/01/21.
//

import Foundation
        

struct Category: Hashable, Identifiable, Codable {
    let id = UUID()
    var name: String?
    var image: String?
}
        
struct CategoryResponseModel: Hashable, Codable {
    var code: Int?
    var response: CategoryResponseBody?
    
}
        
struct CategoryResponseBody: Hashable, Codable {
    var videoCategories: [String : Category]?
}
        
    
