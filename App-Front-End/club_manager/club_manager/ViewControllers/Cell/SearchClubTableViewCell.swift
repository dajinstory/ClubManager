//
//  SearchClubTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/10.
//

import UIKit

class SearchClubTableViewCell: UITableViewCell {
    static var identifier = "SearchClubTableViewCell"

    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    
    //@IBOutlet weak var acceptButton: UIButton!
    
    var buttonTapCallback: () -> ()  = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchClubTableViewCell", bundle: nil)
    }
    
    
    
    public func configure(with model: Club){
        self.clubImage.image = UIImage(named: model.clubImage)
        self.clubName.text = model.clubName
//        self.acceptButton.setTitle("승인 요청", for: .normal)
//        self.acceptButton.setTitleColor(UIColor.white, for: .normal)
//        acceptButton.addTarget(self, action: #selector(didTapButton), for: .touchUpOutside)
    }
    
//    @objc func didTapButton(){
//        print("didTapButton")
//        buttonTapCallback()
//
//    }
}
