//
//  WriteViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/02.
//

import UIKit

class WriteViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var allCellsText = [String]()
    var category = ""
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "enter the title"
        return textField
    }()
    
    let contentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter the content"
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = true
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
    
//    private var firstView: UIView = {
//        let firstView = UIView()
//        let cameraButton = UIButton(frame: CGRect(x: 10, y: 20, width: 150, height: 50))
//        cameraButton.setTitle("0/10", for: .normal)
//        cameraButton.invalidateIntrinsicContentSize()
//        cameraButton.backgroundColor = .systemBlue
//        cameraButton.layer.borderWidth = 2
//        cameraButton.addTarget(self, action: #selector(didTapGallery), for: .touchUpInside)
//        firstView.layer.cornerRadius = 7
//        firstView.layer.borderWidth = 2
//        firstView.layer.borderColor = UIColor.gray.cgColor
//        return firstView
//    }()
    
//    lazy var titleText: UITextField = {
//        let width: CGFloat = 250
//        let height: CGFloat = 50
//        let posX: CGFloat = (self.view.bounds.width - width)/2
//        let posY: CGFloat = (self.view.bounds.height - height)/2
//        var title = UITextField(frame: CGRect(x: posX, y: posY, width: width, height: height))
//        title.placeholder = "enter the title"
//        title.delegate = self
//        title.borderStyle = .roundedRect
//        return title
//    }()

//    @objc func didTapCategory(){
//        print("didTapbutton")
//        let dcVC = detailCategoryViewController()
//        dcVC.view.backgroundColor = UIColor.white
//        dcVC.title = "카테고리 선택"
//        self.navigationController?.pushViewController(dcVC, animated: true)
//    }
    

    var toolbar = UIToolbar()
    
    var testBar = UIToolbar()

    func setUpKeyBoardToolBar(){
        toolBarKeyboard.sizeToFit()
        toolBarKeyboard.barTintColor = UIColor.white
       
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let albumbar = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(self.didTapAlbum))
        let tag = UIBarButtonItem(title: "tag", style: .plain, target: self, action: #selector(self.didTapTag))
        let btnDoneBar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButton))
        toolBarKeyboard.items = [albumbar, flexibleSpace, tag, flexibleSpace, btnDoneBar]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        title = "글쓰기"
        print("category \(category)")

        setUpKeyBoardToolBar() // setup toolbar
        contentTextView.inputAccessoryView = toolBarKeyboard
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapClose))
        let tempSave = UIBarButtonItem(title: "임시 저장", style: .plain, target: self, action: #selector(didTapDone))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        
        navigationItem.rightBarButtonItems = [done, tempSave]
    
        FrameTableView.delegate = self
        FrameTableView.dataSource = self
        FrameTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(FrameTableView)
        

    }
    
    @objc func doneButton(){
        print("doneButton")
        self.view.endEditing(true)
    }
    
    @objc func didTapAlbum(){
        self.presentPhotoActionSheet()
    }
    
//    func addImage(img: NSAttributedString){
//        let fullString = NSMutableAttributedString(string: contentTextView.text)
//        fullString.append(img)
//        contentTextView.attributedText = fullString
//    }
    
    @objc func didTapTag(){
        print("did tap tag")
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
   
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = selectedImage
        let newImageWidth = (contentTextView.bounds.size.width - 20)
        let scale = newImageWidth/selectedImage.size.width
        let newImageHeight = selectedImage.size.height * scale
        image1Attachment.bounds = CGRect.init(x: 0, y: 0, width: newImageWidth, height: newImageHeight)
        let attString = NSAttributedString(attachment: image1Attachment)
        contentTextView.textStorage.insert(attString, at: contentTextView.selectedRange.location)
        let range = NSMakeRange(contentTextView.text.count - 1, 0)
        contentTextView.scrollRangeToVisible(range)
        picker.dismiss(animated: true, completion: nil)
//        self.addImage(img: attString)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
    }

    
    @objc func didTapClose(){
        let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController
        tabBarViewController.selectedIndex = 0
        tabBarViewController.modalPresentationStyle = .fullScreen
        present(tabBarViewController, animated: true)
    }
    
    @objc func didTapDone(){
        guard let titleText = titleTextField.text, let contentText = contentTextView.text else { return }
        let alertSave = UIAlertController(title: "글 저장", message:  "글 저장을 완료하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
  
        let OKtAction = UIAlertAction(title: "OK", style: .default, handler: { (okClick) in
            //글 저장 append
            print("info : \(self.category) \(titleText) \(contentText)")
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
//            tableView.addSubview(contentTextField)
//            contentTextField.frame = CGRect(x: 0, y: 110, width: view.bounds.width, height: view.bounds.height - 100)
//            contentTextField.delegate = self
            
            tableView.addSubview(contentTextView)
            contentTextView.frame = CGRect(x: 0, y: 110, width: view.bounds.width, height: view.bounds.height - 100)
            return cellText
        }
        
        return cell
    }
    
    @objc func didTapNu(){
        print("didTapNu")
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing \(String(describing: textField.text))")
    }

        
    func textFieldDidEndEditing(_ textField: UITextField) {
            allCellsText.append(textField.text!)
            print("all cell text : \(allCellsText)")
        }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        textField.resignFirstResponder()
        return true

    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing \(textField.text!)")
        return true
    }

        
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("textfield can edit \(textField)")
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


    
    


