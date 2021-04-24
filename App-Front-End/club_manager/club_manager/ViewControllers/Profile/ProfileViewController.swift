//
//  ProfileViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/29.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    private let userName: UILabel = {
        let label = UILabel()
        label.text = "조소정"
        label.textColor = .black
        return label
    }()
    
    private let sec = ["section1", "section2", "section3"]
    var section1 = ["회원 관리", "회계 장부"]
    var section2 = ["다크 모드", "알림 설정"]
    var section3 = ["로그 아웃", "회원 탈퇴", "앱 정보"]
    
    
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        //dummy
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
    
    private let darkModeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemBlue
        return mySwitch
    }()
    
    private let layoutTableView: UITableView = {
        let layoutTableView = UITableView(frame: .zero, style: .grouped)
        layoutTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //layoutTableView.isHidden = true
        return layoutTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "나의 정보"
        let image = UIImage(systemName: "square.and.arrow.up")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapSetting))
        getUserProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
        imageView.frame = CGRect(x: view.bounds.width/2 - 35, y: 100, width: 70, height: 70)
        userName.frame = CGRect(x: view.bounds.width/2 - 35, y: imageView.bottom + 10, width: 50, height: 25)
        
        layoutTableView.frame = CGRect(x: 0, y: userName.bottom + 20, width: view.bounds.width, height: view.bounds.height - imageView.height - 30)
        
        darkModeSwitch.sizeToFit()
        
        view.addSubview(imageView)
        view.addSubview(userName)
        view.addSubview(layoutTableView)

        
        darkModeSwitch.isOn = false
        
    }
    
    func getUserProfile(){
        print("here")
        let url  = URL(string: "http://13.124.135.59:47000/user")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
             
                    // Convert HTTP Response Data to a String
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response data string:\n \(dataString)")
                        //dataString.filter{$0.}
                    }
        }
        task.resume()
        
    }
    
    @objc func didTapSetting(){
        let vc = EditProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        if(section == 0){
            return section1.count
        }else if(section == 1){
            return section2.count
        }else {
            return section3.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = section1[indexPath.row]
        }else if indexPath.section == 1 {
            if(indexPath.row == 0){
                tableView.addSubview(darkModeSwitch)
                darkModeSwitch.frame = CGRect(x: view.frame.size.width - darkModeSwitch.frame.size.width - 20, y: 220, width: darkModeSwitch.frame.width, height: darkModeSwitch.frame.height)
            }
            cell.textLabel?.text = section2[indexPath.row]
        }else {
            cell.textLabel?.text = section3[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //회원 관리
        if (indexPath.section == 0 && indexPath.row == 0){
//            let manageVc = UserManageViewController()
//            self.navigationController?.pushViewController(manageVc, animated: true)
            //swiftui
            let swiftUI_UM = UIHostingController(rootView: UserManager(datas: UserManager.getAllUser))
            swiftUI_UM.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(swiftUI_UM, animated: true)
        }else if(indexPath.section == 0 && indexPath.row == 1){
            //회계 장부 권한 가지고 있는지 아닌지 확인
            //manager이면 -> 열람 o
            //x -> alert 창 
            print("회계 장부")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
