//
//  WriteViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/02.
//

import UIKit

class WriteViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
   // var imageArray : [Int] = []
    //var imageArray: Array = Array
    
    private let contentView: UIView = {
        let contentCView = UIView()
        return contentCView
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("게시판 선택", for: .normal)
        button.layer.borderWidth = 2
        return button
    }()
    
    private var firstView: UIView = {
        let firstView = UIView()
        let cameraButton = UIButton(frame: CGRect(x: 10, y: 20, width: 150, height: 50))
        cameraButton.setTitle("0/10", for: .normal)
        cameraButton.invalidateIntrinsicContentSize()
        cameraButton.backgroundColor = .systemBlue
        cameraButton.layer.borderWidth = 2
        cameraButton.addTarget(self, action: #selector(didTapGallery), for: .touchUpInside)
        firstView.layer.cornerRadius = 7
        firstView.layer.borderWidth = 2
        firstView.layer.borderColor = UIColor.gray.cgColor
        return firstView
    }()
    
    lazy var titleText: UITextField = {
        let width: CGFloat = 250
        let height: CGFloat = 50
        let posX: CGFloat = (self.view.bounds.width - width)/2
        let posY: CGFloat = (self.view.bounds.height - height)/2
        var title = UITextField(frame: CGRect(x: posX, y: posY, width: width, height: height))
        title.placeholder = "enter the title"
        title.delegate = self
        title.borderStyle = .roundedRect
        return title
    }()

    
    @objc func didTapGallery(){
        print("didTapGallery")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard (info[UIImagePickerController.InfoKey.editedImage] as? UIImage) != nil else {
            return
        }
//        //collectionview imagecell로 넣기
//        imageArray.append(
        //self.imageView.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    let imageCollectionView: UICollectionView! = nil
    

    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "글쓰기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        
        
//        imageCollectionView.delegate = self
//        imageCollectionView.dataSource = self
        
        contentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 2000)
        categoryButton.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 100)
        firstView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 100)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: (scrollView.width * 3) + 20)
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        contentView.addSubview(firstView)
        contentView.addSubview(categoryButton)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
    
    }
    
    @objc func didTapClose(){
        print("didTapClose")
    }
    
    @objc func didTapDone(){
        print("didTapDone")
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing \(String(describing: textField.text))")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing \(textField.text!)")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        textField.resignFirstResponder()
        return true

    }



}

//extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath.row)
//        return cell
//    }
//
//
//}


