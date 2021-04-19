//
//  AddClubViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit

class AddClubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "클럽 만들기"
    }
    
    private let clubImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    lazy var club_president: UIView = {
        let view = UIView()
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "클럽 장"
        var president = UILabel(frame: CGRect(x: label.frame.maxX + 10, y: 0, width: 50, height: 21))
        president.text = "조소정"
        view.addSubview(label)
        view.addSubview(president)
        return view
    }()
    
    lazy var clubName_Label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "클럽 이름"
        return label
    }()
    
    lazy var clubCategory_Label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "카테고리"
        return label
    }()
    
    lazy var clubSummary_Label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "한 줄 소개"
        return label
    }()

    var clubName_Textfield: UITextField = {
        var title = UITextField()
        title.placeholder = "enter the clubName"
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.blue.cgColor
        title.borderStyle = .roundedRect
        return title
    }()
    
    var clubCategory_textField: UITextField = {
        var title = UITextField()
        title.placeholder = "enter the category"
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.blue.cgColor
        title.borderStyle = .roundedRect
        return title
    }()
    
    var clubSummary_textField: UITextField = {
        var title = UITextField()
        title.placeholder = "enter the Summary"
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.blue.cgColor
        title.borderStyle = .roundedRect
        return title
    }()
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(clubImage)
        view.addSubview(clubName_Label)
        view.addSubview(clubName_Textfield)
        view.addSubview(club_president)
        view.addSubview(clubCategory_Label)
        view.addSubview(clubCategory_textField)
        view.addSubview(clubSummary_Label)
        view.addSubview(clubSummary_textField)
        
        clubImage.frame = CGRect(x: view.bounds.width/2 - 35, y: 200, width: 70, height: 70)
        clubName_Label.frame = CGRect(x: 50, y: clubImage.bottom + 20, width: clubName_Label.frame.width, height: clubName_Label.frame.height)
        print(clubName_Label.frame.maxX + 10)
        clubName_Textfield.frame = CGRect(x: 100, y: clubImage.bottom + 20, width: clubName_Textfield.frame.width, height: clubName_Textfield.frame.height)
        
        club_president.frame = CGRect(x: 50, y: clubName_Label.bottom + 10, width: club_president.frame.width, height: club_president.frame.height)
        
        clubCategory_Label.frame = CGRect(x: 50, y: club_president.bottom + 20, width: clubCategory_Label.frame.width, height: clubCategory_Label.frame.height)
        clubCategory_textField.frame = CGRect(x: clubCategory_Label.frame.maxX + 10, y:  club_president.bottom + 20, width: clubCategory_textField.frame.width, height: clubCategory_textField.frame.height)
        
        clubSummary_Label.frame = CGRect(x: 50, y: clubCategory_Label.bottom + 10, width: clubSummary_Label.frame.width, height: clubSummary_Label.frame.height)
        clubSummary_textField.frame = CGRect(x: clubSummary_Label.frame.maxX + 10, y: clubCategory_textField.bottom + 10, width: clubSummary_textField.frame.width, height: clubSummary_textField.frame.height)
        
    }
    

}

extension AddClubViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
