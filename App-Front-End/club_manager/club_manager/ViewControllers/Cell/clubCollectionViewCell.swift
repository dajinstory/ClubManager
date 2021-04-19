//
//  clubCollectionViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit

class clubCollectionViewCell: UICollectionViewCell {
    static var identifier = "clubCollectionViewCell"
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var mytextView: UILabel!
    static func nib() -> UINib {
        return UINib(nibName: "clubCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: Club){
        self.myImageView.image = UIImage(named: model.clubImage)
        self.myImageView.contentMode = .scaleAspectFill
        self.myImageView.clipsToBounds = true
        self.mytextView.text = model.clubName
    }
    
    public func configureForWait(with model: Club){
        self.myImageView.image = UIImage(named: model.clubImage)
        self.myImageView.contentMode = .scaleAspectFill
        self.myImageView.clipsToBounds = true
        self.mytextView.text = model.clubName
    }
  

}
