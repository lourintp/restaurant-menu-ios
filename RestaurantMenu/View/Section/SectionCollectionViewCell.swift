//
//  SectionCollectionViewCell.swift
//  RestaurantMenu
//
//  Created by Thiago Lourin on 23/12/21.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
           
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
                
    }
            
    override init(frame: CGRect) {
        super.init(frame: frame)
         
    }
    
    func setupCell(sectionName: String) {
        nameLabel.text = sectionName
    }
    
    func setSelected(isSelected: Bool) {
        nameLabel.textColor = isSelected ? UIColor(named: "SubtitleColor") : UIColor(named: "DisabledColor")
        bottomView.isHidden = !isSelected
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
