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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingForLabel()
    }
    
    static let identifier = "DetailSection1TableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailSection1TableViewCell", bundle: nil)
    }
    
    func configure(modelBoard: BoardData, modelUser: User){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        category.text = "\(modelBoard.BoardCategory) >"
        category.textColor = .gray
        title.text = modelBoard.title
        userName.text = modelUser.userName
        date.text = dateFormatter.string(from: modelBoard.date)
        count.text = "조회수 \(modelBoard.count)"
        
        
    }
    
    func settingForLabel(){
        self.title.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
}

