//
//  RestaurantMenuPresenter.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 22/12/21.
//

import Foundation

protocol RestaurantMenuView {
    func populateRestaurantName(_ name: String)
    func onFetchMenuItems(_ items: [MenuItem])
    func populateSections(_ sections: [String])
    func onSelecteSubsection(_ subsection: String)
    func onError(message: String)
}

protocol RestauranteMenuPresenterProtocol {
    var view: RestaurantMenuView { get set }
    func loadMenuItems()
    func onItemSelected(subsection: String)
    
}

class RestaurantMenuPresenter: RestauranteMenuPresenterProtocol {
    
    var view: RestaurantMenuView
    private let apiClient: APIClientProtocol
    
    init(view: RestaurantMenuView, apiClient: APIClientProtocol) {
        self.view = view
        self.apiClient = apiClient
    }
    
    func loadMenuItems() {
        apiClient.get(MenuItemsRequest(id: "38233881122639360")) { response in
            switch response {
            case .success(let response):
                let menuItemsResponse = response as! MenuItemsResponse
                let items = menuItemsResponse.items
                self.view.populateRestaurantName(items.first!.restaurantName)
                self.view.populateSections(self.splitBySubsection(items: items))
                self.view.onFetchMenuItems(items)
                
            case .failure(let error):
                print(error?.localizedDescription ?? "")
                break
            }
        }
    }
    
    func onItemSelected(subsection: String) {
        self.view.onSelecteSubsection(subsection)
    }
    
    private func splitBySubsection(items: [MenuItem]) -> [String] {
        let allSections = Set(items.map( {$0.subsection} )).sorted()
        return allSections
    }
    
}
