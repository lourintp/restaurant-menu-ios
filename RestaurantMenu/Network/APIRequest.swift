//
//  APIRequest.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 18/12/21.
//

import Foundation

public protocol APIRequest: Codable {
    
    var resourcePath: String { get }
    var method: HttpMethod { get }
    
    associatedtype Response: APIResponse
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
