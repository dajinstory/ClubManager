//
//  DetailSection1TableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/15.
//

import UIKit

class DetailSection1TableViewCell: UITableViewCell {

    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var count: UILabel!
    
    static let identifier = "DetailSection1TableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailSection1TableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(modelBoard: BoardData, modelUser: User){
        let dateFormatter = DateFormatter()
        category.text = modelBoard.BoardCategory[0]
        title.text = modelBoard.title
        userName.text = modelUser.userName
        date.text = dateFormatter.string(from: modelBoard.date)
        count.text = "조회수 10"
        
    }
    
}

