//
//  NetworkError.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation

enum NetworkError: Error, Equatable {
    
    case invalidUrlString(url: String)
    case invalidURL(url: URLComponents)
    case emptyPath
    
}
