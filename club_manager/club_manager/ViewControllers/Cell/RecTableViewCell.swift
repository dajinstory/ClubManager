//
//  RecTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/30.
//

import UIKit

class RecTableViewCell: UITableViewCell {

    @IBOutlet weak var recImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    static let identifier = "RecTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "RecTableViewCell", bundle: nil)
    }
    
    public func configure(with model: recClub){
//        self.recImage.image = UIImage(named: model.clubImage)
        self.recImage.image = UIImage(systemName: "person.fill")
        self.title.text = model.clubName
        self.content.text = model.clubSummary
        self.category.text = model.category
        self.category.textColor = UIColor.red
    
    }
    
}
