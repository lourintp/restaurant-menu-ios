//
//  NetworkAdapter.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation
import Alamofire

public protocol NetworkAdapter {
    func get(destination: String, headers: [String: String], payload: [String: Any], responseHandler: @escaping (Data) -> ())
}

public class AlamofireNetworkAdapter: NetworkAdapter {
    
    public func get(destination: String, headers: [String: String], payload: [String : Any], responseHandler: @escaping (Data) -> ()) {
        AF.request(destination, method: .get, encoding: payload as! ParameterEncoding, headers: HTTPHeaders(headers)).validate()
            .responseData { (responseData) in
            guard let data = responseData.data else {
                return
            }
                                    
            responseHandler(data)
        }
    }
    
}
