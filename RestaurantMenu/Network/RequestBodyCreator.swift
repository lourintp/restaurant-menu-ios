//
//  RequestCreator.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 18/12/21.
//

import Foundation

protocol RequestBodyCreatorProtocol {
    func create<T: APIRequest>(for request: T, url: String) throws -> URLRequest
}

public struct RequestBodyCreator: RequestBodyCreatorProtocol {
    
    func create<T>(for request: T, url: String) throws -> URLRequest where T : APIRequest {
        guard let baseURL = URLComponents(string: try url.asURL().appendingPathComponent(request.resourcePath).absoluteString) else {
            fatalError("Bad resource name: \(request.resourcePath)")
        }

        guard let url = baseURL.url else { throw NetworkError.invalidURL(url: baseURL) }
        
        if request.resourcePath.isEmpty {
            throw NetworkError.emptyPath
        }
        
        var requestData = URLRequest(url: url)
        
        if request.method != .get { requestData.httpBody = try toData(request) }
                
        requestData.httpMethod = request.method.rawValue
        requestData.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestData.headers = ["X-API-KEY": apiKey]
        return requestData
    }
    
    private func toData<T: APIRequest>(_ data: T) throws -> Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        jsonEncoder.dateEncodingStrategy = .iso8601
            
        return try jsonEncoder.encode(data)
    }
    
    private var apiKey: String {
        get {
            guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
                fatalError("Couldn't find key 'API_KEY'.")
            }
            return apiKey
        }
    }
    
}
