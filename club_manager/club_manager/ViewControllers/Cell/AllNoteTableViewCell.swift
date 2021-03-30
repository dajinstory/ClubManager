//
//  AllNoteTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/25.
//

import UIKit

import UIKit

class AllNoteTableViewCell: UITableViewCell {
    static let identifier = "AllNoteTableViewCell"
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var dateTime: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
  

    override func layoutSubviews() {
        super.layoutSubviews()
        setting()
    }
    
    public func configure(with model: cellData){
        self.title.text = model.title
        self.content.text = model.content
        self.dateTime.text = "09:07 PM"
        self.userName.text = model.userName
        self.profileImage.image = UIImage(systemName: "person.crop.circle")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "AllNoteTableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setting(){
        title.font = .systemFont(ofSize: 19, weight: .regular)
        title.font = UIFont.boldSystemFont(ofSize: 12.0)
        title.numberOfLines = 0
        content.font = .systemFont(ofSize: 10, weight: .regular)
        content.numberOfLines = 0
        
        
    }

}

