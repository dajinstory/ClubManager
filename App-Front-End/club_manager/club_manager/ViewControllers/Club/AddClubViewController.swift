//
//  AddClubViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit
import DropDown

class AddClubViewController: UIViewController, UIGestureRecognizerDelegate {

    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var clubName_Textfield: UITextField!
    @IBOutlet weak var clubPresident: UITextField!
    
    @IBOutlet weak var clubCategory_button: UIButton!
    
    @IBOutlet weak var clubSummary_textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addbuttonSetting()
        profileImageSetting()
        clubName_TextfieldSetting()
        clubCategory_buttonSetting()
        clubSummary_textFieldSetting()
        clubPresident.text = "조소정"
        

        navigationItem.title = "클럽 만들기"
        
        
        //for keyboard show/ hide action -> view's y change
        NotificationCenter.default.addObserver(self, selector: #selector(AddClubViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(AddClubViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        

        clubCategory_button.addTarget(self, action: #selector(didTapDropDown), for: .touchUpInside)
        
        clubCategory_dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            clubCategory_button.setTitle("\(item)", for: .normal)
            clubCategory_button.setTitleColor(UIColor.black, for: .normal)
            clubCategory_button.layer.borderWidth = 1
            clubCategory_button.layer.borderColor = UIColor.black.cgColor
            clubCategory_button.backgroundColor = UIColor.clear
        }
        
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangedProfilePic))
        gesture.delegate = self
        profileImage.addGestureRecognizer(gesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
        if(clubName_Textfield.isEditing){
            self.view.frame.origin.y = 0
        }else{
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
      
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    @objc func didTapDropDown(){
        clubCategory_dropDown.anchorView = clubCategory_button
        clubCategory_dropDown.show()
    }
    
    func addbuttonSetting(){
        addButton.setTitle("만들기", for: .normal)
        addButton.backgroundColor = UIColor.black
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.addTarget(self, action: #selector(didTapMakeButton), for: .touchUpInside)
    }
    
    func profileImageSetting(){
        profileImage.image = UIImage(systemName: "square.stack")!

        profileImage.tintColor = .black
        profileImage.tintColor = .lightGray
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.layer.borderWidth = 1
        profileImage.clipsToBounds = true
        
    }
    
    func clubName_TextfieldSetting(){
        clubName_Textfield.placeholder = "클럽 이름 입력"
        clubName_Textfield.layer.borderWidth = 2
        clubName_Textfield.layer.borderColor = UIColor.black.cgColor
        clubName_Textfield.layer.cornerRadius = 2
        clubName_Textfield.borderStyle = .roundedRect
    }
    
    func clubCategory_buttonSetting(){
        clubCategory_button.setTitle("카테고리 선택 >", for: .normal)
        clubCategory_button.backgroundColor = UIColor.blue
        clubCategory_button.setTitleColor(UIColor.white, for: .normal)
        clubCategory_button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    func clubSummary_textFieldSetting(){
        clubSummary_textField.text = "한줄 소개 입력"
        clubSummary_textField.textColor = .systemGray
        clubSummary_textField.layer.borderWidth = 2
        clubSummary_textField.layer.borderColor = UIColor.black.cgColor
    }
    
 

    
    let clubCategory_dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = ["생활", "여가", "스포츠", "팬"]
        return dropDown
    }()
    

    
   
    
    @objc func didTapMakeButton(){
        guard !clubName_Textfield.text!.isEmpty,  !clubSummary_textField.text!.isEmpty else {
                alertUserLoginError()
                return
        }
    
        alertaddedToClubList()
        //alertUserLoginError()

    }
    
    func alertaddedToClubList() {
        let alert = UIAlertController(title: "클럽 생성", message: "클럽 리스트에 추가 되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "생성 실패", message: "모든 정보를 입력해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

    

}

extension AddClubViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func didTapChangedProfilePic(){
        presentPhotoActionSheet()
    }
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile picture",
                                            message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in self?.presentCamera()}))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in self?.presentPhoto()}))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func presentPhoto(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.profileImage.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
