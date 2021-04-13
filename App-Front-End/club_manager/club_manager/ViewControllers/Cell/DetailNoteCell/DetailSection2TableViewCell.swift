//
//  DetailSection2TableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/13.
//

import UIKit

class DetailSection2TableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    
    static let identifier = "DetailSection2TableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailSection2TableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with modelBoard: BoardData){
        self.content.text = modelBoard.content
        
    }
}
