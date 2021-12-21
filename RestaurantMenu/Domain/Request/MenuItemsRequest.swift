//
//  MenuItemsRequest.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 21/12/21.
//

import Foundation

struct MenuItemsRequest: APIRequest {
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    typealias Response = MenuItemsResponse
    
    var method: HttpMethod {
        return .get
    }
    
    var resourcePath: String {
        return "/restaurant/\(id)/menuitems"
    }
    
}
