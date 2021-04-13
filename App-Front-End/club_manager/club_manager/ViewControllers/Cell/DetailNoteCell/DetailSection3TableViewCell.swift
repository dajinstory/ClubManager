//
//  DetailSection3TableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/13.
//

import UIKit

class DetailSection3TableViewCell: UITableViewCell {

    static let identifier = "DetailSection3TableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailSection3TableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(){
        
    }
    
}
