//
//  AddClubViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit
import DropDown

class AddClubViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
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
        
        clubImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangedProfilePic))
        gesture.delegate = self
        clubImageView.addGestureRecognizer(gesture)
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

    
    private let clubImageView: UIImageView = {
        let imageView = UIImageView()
        var uiImage = UIImage(systemName: "square.stack")!
        
//        uiImage = uiImage.imageResized(to: )
        
        imageView.image = uiImage
        imageView.tintColor = .black
        imageView.tintColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let enterView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    var club_president: UIView = {
        let view = UIView()
        var label = UILabel(frame: CGRect(x: 0, y: 10, width: 100, height: 21))
        label.text = "클럽 장"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
        return view
    }()
    
    var president = UILabel()
    
    var clubName_Label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "클럽 이름"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var clubCategory_Label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "카테고리"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var clubSummary_Label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        label.text = "한 줄 소개"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    lazy var clubName_Textfield: UITextField = {
        var title = UITextField()
        title.placeholder = "클럽 이름 입력"
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.black.cgColor
        title.layer.cornerRadius = 2
        title.borderStyle = .roundedRect
        return title
    }()
    
    let clubCategory_dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = ["생활", "여가", "스포츠", "팬"]
        return dropDown
    }()
    
    var clubCategory_button: UIButton = {
        var button = UIButton()
        button.setTitle("카테고리 선택 >", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    
//    lazy var clubCategory_textField: UITextField = {
//        var title = UITextField()
//        title.placeholder = "카테고리 선택"
//        title.layer.borderWidth = 2
//        title.layer.borderColor = UIColor.blue.cgColor
//        title.borderStyle = .roundedRect
//        return title
//    }()
    
    lazy var clubSummary_textField: UITextView = {
        var title = UITextView()
        title.text = "한줄 소개 입력"
        title.textColor = .systemGray
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.black.cgColor
        return title
    }()
    
    var make_Button: UIButton = {
        let button = UIButton()
        button.setTitle("만들기", for: .normal)
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(didTapMakeButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapMakeButton(){
        guard !clubName_Textfield.text!.isEmpty, !president.text!.isEmpty,  !clubSummary_textField.text!.isEmpty else {
                alertUserLoginError()
                return
        }
    
        print("\(clubImageView.image!) \(clubName_Textfield.text!) \(president.text!) \(clubSummary_textField.text!)")
        alertaddedToClubList()

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
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        president.text = "조소정"
        president.font = .boldSystemFont(ofSize: 20)
        president.textColor = UIColor.systemBlue
        
        view.addSubview(clubImageView)
        view.addSubview(enterView)
        
        enterView.addSubview(clubName_Label)
        enterView.addSubview(clubName_Textfield)
        
        enterView.addSubview(club_president)
        club_president.addSubview(president)
        
        
        enterView.addSubview(clubCategory_Label)
        enterView.addSubview(clubCategory_button)
        
        enterView.addSubview(clubSummary_Label)
        enterView.addSubview(clubSummary_textField)

        enterView.addSubview(make_Button)
        
        let viewHeight:CGFloat = 50
        let margin:CGFloat = 40
    
        
        clubImageView.frame = CGRect(x: view.bounds.width/2 - 100, y: 100, width: 200, height: 200)
        enterView.frame = CGRect(x: 0, y: clubImageView.bottom, width: view.width, height: view.height - clubImageView.height)
    
        clubName_Label.frame = CGRect(x: 20, y: 20, width: clubName_Label.frame.width, height: viewHeight)
        
        clubName_Textfield.frame = CGRect(x: clubName_Label.frame.maxX + 10, y: clubName_Label.frame.minY, width: 200, height: viewHeight)
        
        
        club_president.frame = CGRect(x: 20, y: clubName_Label.bottom + margin , width: view.width - 40, height: viewHeight)
        president.frame = CGRect(x: 150, y: 0, width: 100, height: viewHeight)
        
        clubCategory_Label.frame = CGRect(x: 20, y: club_president.bottom + margin, width: clubCategory_Label.frame.width, height: viewHeight)
        clubCategory_button.frame = CGRect(x: clubCategory_Label.frame.maxX + 10, y:  club_president.bottom + margin, width: 200, height: viewHeight)
        
        clubSummary_Label.frame = CGRect(x: 20, y: clubCategory_Label.bottom + margin, width: clubSummary_Label.frame.width, height: viewHeight)

        clubSummary_textField.frame = CGRect(x: clubSummary_Label.frame.maxX + 10, y: clubCategory_button.bottom + margin, width: 200, height: viewHeight * 2)
        
        make_Button.frame = CGRect(x: view.bounds.width/2 - 70, y: clubSummary_textField.bottom + margin, width: 100, height: viewHeight)

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
        self.clubImageView.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
