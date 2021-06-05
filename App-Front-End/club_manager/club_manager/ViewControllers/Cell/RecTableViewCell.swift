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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFont()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "RecTableViewCell", bundle: nil)
    }
    
    public func configure(with model: Club){
        //self.recImage.image = UIImage(named: model.clubImage)
        self.title.text = model.clubName
        self.content.text = "한줄 설명 : \(model.clubSummary)"
        self.category.text = "카테고리 : \(model.category)"
        
        self.category.textColor = UIColor.red
    
    }
    
    func setupFont(){
        self.title.font = .boldSystemFont(ofSize: 20)
        self.content.textColor = .systemGray
        self.category.textColor = UIColor.systemBlue
    }
    
}
