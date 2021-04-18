//
//  TextFieldTableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/15.
//

import UIKit

//protocol TextFieldTableViewCellDelegate: class {
//    func onTouchTitletTextFlied(from cell: TextFieldTableViewCell)
//}

class TextFieldTableViewCell: UITableViewCell {
    
    static let identifier = "TextFieldTableViewCell"

//    weak var delegate: TextFieldTableViewCellDelegate?
    
    let dataTextField: UITextField = {
        let textField = UITextField()
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(WriteViewController.self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    
//    lazy var titleTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "enter the title"
//        //textField.delegate = self
//        textField.layer.borderWidth = 2
////        textField.addTarget(self, action: #selector(onTouchTitletTextFlied), for: .touchUpInside)
//        textField.layer.borderColor = UIColor.blue.cgColor
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dataTextField.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        addSubview(dataTextField)
        //titleTextField.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TextFieldTableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        print("valueChanged")
//        switch textField.tag {
//        case TextFieldData.nameTextField.rawValue:
//        user.name = textField.text
//        case TextFieldData.surnameTextField.rawValue:
//        user.surname = textField.text
//
//        case TextFieldData.emailTextField.rawValue:
//        user.email = textField.text
//
//        case TextFieldData.phoneTextField.rawValue:
//        user.phoneNumber = textField.text
//
//        case TextFieldData.passwordTextField.rawValue:
//        user.password = textField.text
//        textField.isSecureTextEntry = true
//
//        case TextFieldData.repeatPasswordTextField.rawValue:
//        user.repeatPassword = textField.text
//        textField.isSecureTextEntry = true
//        default:
//            break
        }


}
