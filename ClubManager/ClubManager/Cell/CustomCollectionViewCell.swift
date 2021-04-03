//
//  CustomCollectionViewCell.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let clubImageView: UIImageView = {
        let clubImageView = UIImageView()
        clubImageView.image = UIImage(systemName: "house")
        clubImageView.backgroundColor = .yellow
        clubImageView.contentMode = .scaleAspectFit
        clubImageView.clipsToBounds = true
        return clubImageView
    }()
    
    private let myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Name"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        return myLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray
        contentView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        //contentView.addSubview(clubImageView)
        //contentView.addSubview(myLabel)
    }
   
    
    
    required init?(coder: NSCoder){
        fatalError("init(Coder:} has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //myLabel.frame = CGRect(x: 10, y: contentView.frame.size.height - 100, width: contentView.frame.size.width - 50, height: 50)
        
        //clubImageView.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 50, height: contentView.frame.size.height - 100)
    }
    
}
