//
//  ViewController.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 18/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiClient = APIClient(networkAdapter: AlamofireNetworkAdapter(), requestBody: RequestBodyCreator())
        
        apiClient.get(MenuItemsRequest(id: "3278325797290062")) { result in
            switch result {
            case .failure(let error):
                print(error?.localizedDescription ?? "")
                break
            case .success(let response):
                print(response)
                break
            }
        }
    }


}

