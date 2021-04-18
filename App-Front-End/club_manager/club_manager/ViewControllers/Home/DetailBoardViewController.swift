//
//  DetailBoardViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit

class DetailBoardViewController: UIViewController {
    
    var note: [BoardData] = []
    var userData: [User] = []
    
    var FrameTableView: UITableView = {
        var table = UITableView()
        table.register(DetailSection1TableViewCell.nib(), forCellReuseIdentifier: DetailSection1TableViewCell.identifier)
        table.register(DetailSection2TableViewCell.nib(), forCellReuseIdentifier: DetailSection2TableViewCell.identifier)
        table.register(DetailSection3TableViewCell.nib(), forCellReuseIdentifier: DetailSection3TableViewCell.identifier)
        return table
    }()
    
//    var commentTableView: UITableView = {
//        var table = UITableView()
//        table.register(DetailSection3TableViewCell.nib(), forCellReuseIdentifier: DetailSection3TableViewCell.identifier)
//        return table
//    }()
    
    let toolbar = UIToolbar()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(FrameTableView)
        view.addSubview(toolbar)
        toolbarSetup()
        FrameTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 200)
        FrameTableView.dataSource = self
        FrameTableView.delegate = self
        getUserInfo()
//        for i in note {
//            print(" \(i.BoardCategory) and \(i.content) and \(i.title) \(i.userName) \( i.comment)")
//        }
        initRefresh()
        
    

    }
    
    func getUserInfo(){
        userData.append(User(id: 1, userImage: "multiply.circle.fil", userName: "조소정", userEmail: "spqjf12345"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func toolbarSetup(){
        toolbar.barTintColor = .white

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true

        var items: [UIBarButtonItem] = []

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        let toolbarItem1 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        let toolbarItem2 = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(didTapShareToolBar))
        let toolbarItem3 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)

        items.append(toolbarItem1)
        items.append(flexibleSpace)
        items.append(toolbarItem2)
        items.append(flexibleSpace)
        items.append(toolbarItem3)

        items.forEach { (item) in
            item.tintColor = .orange
        }


        toolbar.setItems(items, animated: true)
    }
    func initRefresh(){
        print("init")
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullRefresh(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "refresh ..")
        FrameTableView.addSubview(refresh)
        
    }
    
    @objc func didPullRefresh(refresh: UIRefreshControl){
        refresh.endRefreshing() // refresh end
        FrameTableView.reloadData()
    }
    
    @objc func didTapShareToolBar(){
        guard let image = UIImage(systemName: "bell.fill"), let url = URL(string: "https://google.com") else { return }
        let shareSheetVc = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVc, animated: true, completion: nil)
    }
    

}

extension DetailBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("index \(indexPath.row)")
        let cell1 = tableView.dequeueReusableCell(withIdentifier: DetailSection1TableViewCell.identifier) as! DetailSection1TableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: DetailSection2TableViewCell.identifier) as! DetailSection2TableViewCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: DetailSection3TableViewCell.identifier) as! DetailSection3TableViewCell
        if(indexPath.row == 0){
            print("1")
            //cell1.configure(with: userData[0], modelBoard: note[0])
            return cell1
        }else if(indexPath.row == 1){
            print("2")
            cell2.configure(with: note[0])
            return cell2
        }else if(indexPath.row == 2){
            print("3")
            let cell3Height:CGFloat = 500
            cell3.size(width: cell3.bounds.width, height : cell3Height)
            return cell3
        }
       
        return cell1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){//title
            return 100
        }else if(indexPath.row == 1){ //content
            return 300
        }else { //comment
            return 500
        }
//        tableView.rowHeight = UITableView.automaticDimension
//        return 500
    }
  
    
    
}
