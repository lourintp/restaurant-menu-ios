//
//  String+Extension.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 20/12/21.
//

import Foundation

extension String {
    
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidUrlString(url: self) }

        return url
    }
}
