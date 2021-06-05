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
    
    func configure(modelBoard: Post, modelUser: User){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        category.text = "\(modelBoard.BoardCategory) >"
        category.textColor = .gray
        title.text = modelBoard.title
        userName.text = modelUser.name
        date.text =  modelBoard.date
        
        
    }
    
    func settingForLabel(){
        self.title.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
}

