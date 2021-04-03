//
//  ProfileViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/29.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "text"
        return label
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 40, y: 30, width: 70, height: 70)
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
        layoutTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        view.addSubview(layoutTableView)
        layoutTableView.addSubview(imageView)
        
        
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
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
            tableView.addSubview(label)
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/3
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
