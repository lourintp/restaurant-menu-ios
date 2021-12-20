//
//  Result.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse)
    case failure(NetworkError?)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void

public struct DataContainer<Result: Decodable> : Decodable {
    public let result: Result
}
