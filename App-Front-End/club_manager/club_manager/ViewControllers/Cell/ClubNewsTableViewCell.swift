//
//  ClubNewsTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/29.
//

import UIKit


class ClubNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var ClubImage: UIImageView!
    @IBOutlet weak var ClubTitle: UILabel!
    @IBOutlet weak var ClubContent: UILabel!
    
    static let identifier = "ClubNewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func layoutSubviews() {
        settupFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var topInset: CGFloat = 0
    var leftInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var rightInset: CGFloat = 0
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutMargins = UIEdgeInsets(top: topInset, left: leftInset, bottom: leftInset, right: rightInset)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "ClubNewsTableViewCell", bundle: nil)
    }
    
    public func configure(with model: Club){
        self.ClubImage.image = UIImage(named: model.clubImage)
        self.ClubTitle.text = model.clubName
        self.ClubContent.text = model.note1
    
    }
    
    func settupFont(){
        self.ClubContent.tintColor = .darkGray
        self.ClubTitle.font = .boldSystemFont(ofSize: 15)
    }
    
}
