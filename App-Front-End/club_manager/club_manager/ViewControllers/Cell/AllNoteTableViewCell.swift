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
    
  
    @IBOutlet weak var comment: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setting()
    }
    
    public func configure(with modelBoard: BoardData, modelUser: User){
        self.title.text = modelBoard.title
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd HH:mm"
        self.dateTime.text = dateFormat.string(from: Date())
        self.userName.text = modelUser.userName
        self.profileImage.image = UIImage(systemName: "person.crop.circle")
        self.comment.text = "댓글" 
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
        //title.font = .systemFont(ofSize: 30, weight: .regular)
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.numberOfLines = 0
        
    }

}

