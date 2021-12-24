//
//  MenuItemsResponse.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation

struct MenuItemsResponse: APIResponse {
    
    let totalResults: Int
    let page: Int
    let totalPages: Int
    let morePages: Bool
    let numResults: Int
    let items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case totalResults
        case page
        case totalPages = "total_pages"
        case morePages = "more_pages"
        case numResults
        case items = "data"
    }
    
}

struct MenuItem: APIResponse {
    
    let description: String
    let name: String
    let subsection: String
    let restaurantName: String
    let pricing: [Pricing]
    
    enum CodingKeys: String, CodingKey {
        case description = "menu_item_description"
        case name = "menu_item_name"
        case subsection
        case restaurantName = "restaurant_name"
        case pricing = "menu_item_pricing"
    }
}

struct Pricing: APIResponse {
    let price: Double
    let currency: String
    let priceString: String
}
