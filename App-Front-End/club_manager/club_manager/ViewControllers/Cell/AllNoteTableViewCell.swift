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
    
  

    override func layoutSubviews() {
        super.layoutSubviews()
        setting()
    }
    
    public func configure(with model: BoardData){
        self.title.text = model.title
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd HH:mm"
        self.dateTime.text = dateFormat.string(from: Date())
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
        
    }

}

