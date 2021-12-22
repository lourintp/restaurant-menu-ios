//
//  SubsectionLabelView.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 22/12/21.
//

import UIKit

class SubsectionLabelView: UIView {
        
    private let labelSectionName = UILabel()
    private let contentView = UIControl()
    
    public init(dataSource: SubsectionDataSource) {
        self.labelSectionName.text = dataSource.subsectionName
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
    
    override func didMoveToSuperview() {
        clipsToBounds = true
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(labelSectionName)
        labelSectionName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 80),
            heightAnchor.constraint(equalToConstant: 100),
            contentView.widthAnchor.constraint(equalToConstant: 80),
            contentView.heightAnchor.constraint(equalToConstant: 80),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelSectionName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelSectionName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelSectionName.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelSectionName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelSectionName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelSectionName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        super.didMoveToSuperview()
    }

}

struct SubsectionDataSource {
    let subsectionName: String
}
