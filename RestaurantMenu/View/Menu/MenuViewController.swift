//
//  MenuViewController.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 18/12/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var sections: [String] = []
    private var indexSelected: Int = 0
    
    private var presenter: RestauranteMenuPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32
        collectionView.collectionViewLayout = layout
        
        presenter = RestaurantMenuPresenter(view: self, apiClient: APIClient(networkAdapter: AlamofireNetworkAdapter(), requestBody: RequestBodyCreator()))        
        
        presenter.loadMenuItems()
    }
    
}

extension MenuViewController: RestaurantMenuView {
    
    func populateSections(_ sections: [String]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func onFetchMenuItems(_ items: [MenuItem]) {
        
    }
    
    func onSelecteSubsection(_ subsection: String) {
        
    }
    
    func onError(message: String) {
        
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if sections.count <= 0 {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SectionCollectionViewCell.self), for: indexPath) as! SectionCollectionViewCell
        cell.setupCell(sectionName: sections[indexPath.row])        
        cell.setSelected(isSelected: indexSelected == indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
}
