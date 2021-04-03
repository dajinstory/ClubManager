//
//  ProfileViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/29.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    private let userName: UILabel = {
        let label = UILabel()
        label.text = "조소정"
        label.textColor = .black
        return label
    }()
    
    private let sec = ["section1", "section2", "section3"]
    var section1 = ["기본 정보"]
    var section2 = ["다크 모드"]
    var section3 = ["로그 아웃", "회원 탈퇴"]
    
    
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
//        imageView.frame = CGRect(x: 40, y: 40, width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let layoutTableView: UITableView = {
        let layoutTableView = UITableView(frame: .zero, style: .grouped)
        layoutTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //layoutTableView.isHidden = true
        return layoutTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "나의 정보"
        let image = UIImage(systemName: "square.and.arrow.up")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapSetting))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
        imageView.frame = CGRect(x: view.bounds.width/2 - 35, y: 150, width: 70, height: 70)
        userName.frame = CGRect(x: view.bounds.width/2, y: imageView.bottom + 10, width: 50, height: 25)
        
        layoutTableView.frame = CGRect(x: 0, y: userName.bottom + 20, width: view.bounds.width, height: view.bounds.height - imageView.height - 30)
        
        view.addSubview(imageView)
        view.addSubview(layoutTableView)
        
        
        
        
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangedProfilePic))
        gesture.delegate = self
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc func didTapSetting(){
        print("did tap setting button")
    }

   

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sec.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sec[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return section1.count
        }else if(section == 2){
            return section2.count
        }else {
            return section3.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if indexPath.section == 1 {
            cell.textLabel?.text = section1[indexPath.row]
        }else if indexPath.section == 2 {
            cell.textLabel?.text = section2[indexPath.row]
        }else {
            cell.textLabel?.text = section3[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
        self.imageView.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
