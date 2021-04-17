//
//  DetailSection1TableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/13.
//

import UIKit

class DetailSection1TableViewCell: UITableViewCell {

    static let identifier = "DetailSection1TableViewCell"
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var boardTitle: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var boardDate: UILabel!
    
    @IBOutlet weak var boardCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailSection1TableViewCell", bundle: nil)
    }
    
    public func configure(with modelClub: User, modelBoard: BoardData){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:MM"
        print("category: \(modelBoard.BoardCategory[0])")
        self.category.text = modelBoard.BoardCategory[0]
        self.boardTitle.text =  modelBoard.title
        self.boardCount.text = String(modelBoard.count) // int -> string
        self.userImage.image = UIImage(systemName: "person.fill")
        self.userName.text = modelClub.userName
        self.boardDate.text = dateFormatter.string(from: modelBoard.date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
