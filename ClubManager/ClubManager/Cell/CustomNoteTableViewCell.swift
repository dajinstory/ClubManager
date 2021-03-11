//
//  CustomNoteTableViewCell.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/03/05.
//

import UIKit

class CustomNoteTableViewCell: UITableViewCell {
    static let identifier = "CustomNoteTableViewCell"
    
    
    private let Title : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let Content : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        Title.frame = CGRect(x: 10, y: 10, width: contentView.width - 20 , height: (contentView.height-20)/2)

        Content.frame = CGRect(x: 10, y: Title.bottom + 10, width: contentView.width - 20, height: (contentView.height-20)/2)
       
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(Title)
        contentView.addSubview(Content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: cellData){
        self.Title.text = model.title
        self.Content.text = model.content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
