//
//  ViewController.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 18/12/21.
//

import UIKit

class ViewController: UIViewController, RestaurantMenuView {
    
    func populateSections(_ sections: Set<String>) {
        
    }
    
    func onFetchMenuItems(_ items: [MenuItem]) {
        
    }
    
    func onSelecteSubsection(_ subsection: String) {
        
    }
    
    func onError(message: String) {
        
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    private let menuScrollView = UIScrollView()
    private var menuButtons: [UIButton?]!
    
    private var presenter: RestaurantMenuPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = RestaurantMenuPresenter(view: self, apiClient: APIClient(networkAdapter: AlamofireNetworkAdapter(), requestBody: RequestBodyCreator()))
        presenter.loadMenuItems()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
        
}

