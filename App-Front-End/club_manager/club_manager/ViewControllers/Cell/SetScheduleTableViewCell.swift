//
//  SetScheduleTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/03.
//

import UIKit

class SetScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    static var identifier = "SetScheduleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SetScheduleTableViewCell", bundle: nil)
    }
    
    public func configure(with model: setSchedule){
        self.date.text = String(model.date.day)
        self.title.text = model.scTitle
    }
}
