//
//  MenuTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/19.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var textMenu: UILabel!
    
    static var idenfifier = "MenuTableViewCell"
    static  func nib() -> UINib {
        return UINib(nibName: "MenuTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    func configure(){
        if textMenu.text  == "전체글" {
            imageMenu.image = UIImage(systemName: "house")
            imageMenu.tintColor = UIColor.black
        }else if textMenu.text == "공지사항" {
            imageMenu.image = UIImage(systemName: "bell")
            imageMenu.tintColor = UIColor.black
        }else if textMenu.text == "T/F 회의록" {
            imageMenu.image =
                UIImage(systemName: "tray.full")

            imageMenu.tintColor = UIColor.black
        }else if textMenu.text == "결산 내역" {
            imageMenu.image = UIImage(systemName: "doc.on.clipboard")
            imageMenu.tintColor = UIColor.black
        }
    }
    
}
