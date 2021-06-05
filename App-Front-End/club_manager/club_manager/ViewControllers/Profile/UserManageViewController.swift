//
//  UserManageViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/14.
//

import UIKit

class UserManageViewController: UIViewController {
    var getAllUSerData: [User] = []
    
    private let FrameTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        FrameTableView.dataSource = self
        FrameTableView.delegate = self
        FrameTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(FrameTableView)
       // addUserData()
    }
    
//    func addUserData(){
//        getAllUSerData.append(User(id: 1, userImage: "person.fill", userName: "조소정", userEmail: "spqjf12345@gmail.com"))
//        getAllUSerData.append(User(id: 2, userImage: "person.fill", userName: "공희재", userEmail: "heejay@gmail.com"))
//        getAllUSerData.append(User(id: 3, userImage: "person.fill", userName: "한다진", userEmail: "daginStory@gmail.com"))
//    }
    

}

extension UserManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAllUSerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        //cell.textLabel?.text = getAllUSerData[indexPath.row].userName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
