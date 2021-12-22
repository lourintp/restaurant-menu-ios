//
//  RestaurantMenuPresenter.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 22/12/21.
//

import Foundation

protocol RestaurantMenuView {
    func onFetchMenuItems(_ items: [MenuItem])
    func populateSections(_ sections: Set<String>)
    func onSelecteSubsection(_ subsection: String)
    func onError(message: String)
}

class RestaurantMenuPresenter {
    
    private let view: RestaurantMenuView
    private let apiClient: APIClientProtocol
    
    init(view: RestaurantMenuView, apiClient: APIClientProtocol) {
        self.view = view
        self.apiClient = apiClient
    }
    
    func loadMenuItems() {
        apiClient.get(MenuItemsRequest(id: "3285880097264500")) { response in
            switch response {
            case .success(let response):
                let menuItemsResponse = response as! MenuItemsResponse
                let items = menuItemsResponse.items
                self.view.populateSections(self.splitBySubsection(items: items))
                
            case .failure(let error):
                print(error?.localizedDescription ?? "")
                break
            }
        }
    }
    
    func splitBySubsection(items: [MenuItem]) -> Set<String> {
        let allSections = Set(items.map( {$0.subsection} ))
        return allSections
    }
    
}
