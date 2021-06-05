//
//  EditProfileViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit

class EditProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileImageSetting()
        
    }
    
    func profileImageSetting(){
        profileImage.image = UIImage(systemName: "person")
        profileImage.tintColor = .lightGray
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.layer.borderWidth = 1
        profileImage.clipsToBounds = true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangedProfilePic))
        gesture.delegate = self
        profileImage.addGestureRecognizer(gesture)
    }


}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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



