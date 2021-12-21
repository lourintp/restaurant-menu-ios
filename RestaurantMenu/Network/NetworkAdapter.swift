//
//  NetworkAdapter.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation
import Alamofire

public protocol NetworkAdapter {
    func get(destination: URLRequest, responseHandler: @escaping (Data) -> ())
}

public class AlamofireNetworkAdapter: NetworkAdapter {
    
    public func get(destination: URLRequest, responseHandler: @escaping (Data) -> ()) {
        
        AF.request(destination).validate().responseData { responseData in
            guard let data = responseData.data else {
                return
            }
                                    
            responseHandler(data)
        }
    }
    
}
