//
//  APIClient.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation

protocol APIClientProtocol {
    func get<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>)
}

class APIClient: APIClientProtocol {
    
    let networkAdapter: NetworkAdapter
    let requestBodyCreator: RequestBodyCreatorProtocol
    
    init(networkAdapter: NetworkAdapter, requestBody: RequestBodyCreatorProtocol) {
        self.networkAdapter = networkAdapter
        self.requestBodyCreator = requestBody
    }
    
    func get<T>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) where T : APIRequest {
        let endpoint: URLRequest
                       
        do {
            endpoint = try requestBodyCreator.create(for: request, url: "https://api.documenu.com/v2")
        } catch let error {
            completion(.failure((error as! NetworkError)))
            return
        }
        
        networkAdapter.get(destination: endpoint) { responseData in
            let stringData = String(data: responseData, encoding: .utf8)
            print("Response body: \(stringData ?? "")")
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: responseData)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(.invalidDecoding(message: error.localizedDescription)))
            }
            
        }
    }
}
