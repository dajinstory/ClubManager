//
//  WriteViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/02.
//

import UIKit

class WriteViewController: UIViewController {
    var category = ""
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "enter the title"
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = true
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textAlignment = NSTextAlignment.left
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.isEditable = true
        return textView
    }()
    
    let toolBarKeyboard = UIToolbar()

    var ctgy: String = "게시판 선택"
    
    var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("게시판 선택", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2
        return button
    }()
    
    private let FrameTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        return table
    }()
    
    var contentString: NSMutableAttributedString? = nil

    var toolbar = UIToolbar()
    
    let dataManager = DataManger()

    func setUpKeyBoardToolBar(){
        toolBarKeyboard.sizeToFit()
        toolBarKeyboard.barTintColor = UIColor.white
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let albumbar = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(self.didTapAlbum))
        let btnDoneBar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButton))
        toolBarKeyboard.items = [albumbar, flexibleSpace,  flexibleSpace, btnDoneBar]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupContentText()

        title = "글쓰기"
        print("category \(category)")
        setUpKeyBoardToolBar() // setup toolbar
        contentTextView.inputAccessoryView = toolBarKeyboard
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapClose))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        
        navigationItem.rightBarButtonItems = [done]
    
        FrameTableView.delegate = self
        FrameTableView.dataSource = self
        contentTextView.delegate = self
        FrameTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(FrameTableView)
    }
    
    func setupContentText(){
        let font = UIFont.systemFont(ofSize: 26)
        let attributes: [NSAttributedString.Key: Any] = [
                   .font: font,
                   .foregroundColor: UIColor.orange
                   ]
        contentString = NSMutableAttributedString(string: "",
                                                         attributes: attributes)
    }
  
    
    @objc func doneButton(){
        print("doneButton")
        self.view.endEditing(true)
    }
    
    @objc func didTapAlbum(){
        self.presentPhotoActionSheet()
    }


    
    @objc func didTapClose(){
        let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController
        tabBarViewController.selectedIndex = 0
        tabBarViewController.modalPresentationStyle = .fullScreen
        present(tabBarViewController, animated: true)
    }
    
    func alertBoardCreateError(){
        let alert = UIAlertController(title: "생성 실패", message: "모든 정보를 입력해 주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func didTapDone(){
        guard let titleText = titleTextField.text, let contentText = contentTextView.text else {
            alertBoardCreateError()
            return
        }
        
        let alertSave = UIAlertController(title: "글 저장", message:  "글 저장을 완료하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
  
        let OKtAction = UIAlertAction(title: "OK", style: .default, handler: { (okClick) in
            if(self.category != "" && titleText != "" && contentText != ""){
                //글 저장 append need
                dataManager.createPost(clubId: currentStatus.clubId, boardId: currentStatus.boardId, title: titleText, content: contentText, writer: currentStatus.userId, comments: "", date: Date(), views: 0)
                
                print("info : \(self.category) \(titleText) \(contentText)")
                let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController
                tabBarViewController.selectedIndex = 0
                tabBarViewController.modalPresentationStyle = .fullScreen
                self.present(tabBarViewController, animated: true)
            }else {
                self.alertBoardCreateError()
            }
          
        })
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)

        alertSave.addAction(OKtAction)
        alertSave.addAction(cancelAction)
        self.present(alertSave, animated: true, completion: nil)
    }
   
}


extension WriteViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func onTouchTitletTextFlied(from cell: TextFieldTableViewCell) {
        print("textfield")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let cellText = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier) as! TextFieldTableViewCell
        
        if(indexPath.row == 0){
            cell.addSubview(categoryButton)
            categoryButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 40)
            return cell
        }else if(indexPath.row == 1){
            titleTextField.frame = CGRect(x: 0, y: 40, width: view.bounds.width, height: 70)
            tableView.addSubview(titleTextField)
            titleTextField.delegate = self
            return cellText
        }else if(indexPath.row == 2){
            tableView.addSubview(contentTextView)
            contentTextView.frame = CGRect(x: 0, y: 110, width: view.bounds.width, height: view.bounds.height - 100)
            return cellText
        }
        
        return cell
    }
    
    @objc func didTapNu(){
        print("didTapNu")
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if (indexPath.row == 0) {
            let dcVC = detailCategoryViewController()
            dcVC.view.backgroundColor = UIColor.white
            dcVC.title = "카테고리 선택"
            guard let titleText = titleTextField.text  else {
                return
            }
            guard let contentText = contentTextView.text else {
                 return
            }
            //잠시 저장해두기
            UserDefaults.standard.setValue(titleText, forKey: "titleText")
            UserDefaults.standard.setValue(contentText, forKey: "contentText")
        
            self.navigationController?.pushViewController(dcVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 40
        }else if(indexPath.row == 1){
            return 70
        }else if(indexPath.row == 2){
            return view.bounds.height - 100
        }
        return 0
    }
}


extension WriteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing called")
        //let nsText = NSMutableAttributedString(string: textView.text)
        //contentString?.append(nsText)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        print("newText : ", newText)
        return true

        
    }
}

extension WriteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
   
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        let image1Attachment = NSTextAttachment()

        image1Attachment.image = selectedImage
        
        let newImageWidth = (contentTextView.bounds.size.width - 20)
        let scale = newImageWidth/selectedImage.size.width
        let newImageHeight = selectedImage.size.height * scale
        image1Attachment.bounds = CGRect.init(x: 0, y: 0, width: newImageWidth, height: newImageHeight)
       
        image1Attachment.image = UIImage(cgImage: (image1Attachment.image?.cgImage!)!, scale: scale, orientation: .up)
        
        let imgString = NSAttributedString(attachment: image1Attachment)
        print("imgString : ", imgString)
        //contentString?.append(imgString)
        
//        let contentHeight = contentTextView.contentSize.height
//        let offSet = contentTextView.contentOffset.x
//        let contentOffset = contentHeight - offSet
//        print("contentOffset \(contentOffset)")
//        contentTextView.contentOffset = CGPoint(x: 0, y: -contentOffset)
        let combination = NSMutableAttributedString()
        combination.append(NSMutableAttributedString(string: contentTextView.text))
        combination.append(imgString)
        contentTextView.attributedText = combination
      
//        let range = NSMakeRange(contentTextView.text.count - 1, 0)
//        contentTextView.scrollRangeToVisible(range)
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

    
    


