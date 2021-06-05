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
    
    public func configure(with modelBoard: Post, modelUser: User){
        self.title.text = modelBoard.title
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY-MM-dd"
        self.dateTime.text = modelBoard.date
        self.userName.text = modelUser.name
//        self.profileImage.image = UIImage(named: modelUser.userImage)
        self.comment.text = "댓글 0"
       
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
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.numberOfLines = 0
    }

}

