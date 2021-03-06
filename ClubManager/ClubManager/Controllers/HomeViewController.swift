//
//  ClubViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/21.
//
//
import UIKit

class HomeViewController: UIViewController, UIToolbarDelegate {
    let toolbar = UIToolbar()
    
    private let contentCView: UIView = {
        let contentCView = UIView()
        //contentCView.backgroundColor = .green
        return contentCView
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomNoteTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var scrollView: UIScrollView!
    
    let data = ["이번주 공지사항입니다.", "11월 회의 내역"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.selectedItem = tabBar.items![0] as UITabBarItem
       
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        
        view.backgroundColor = .systemPurple
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(didTapHome))
        
        contentCView.isUserInteractionEnabled = true
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: screenWidth, height: (scrollView.width * 3) + 20)
        
        scrollView.addSubview(contentCView)
        contentCView.addSubview(tableView)
        
     
        view.addSubview(scrollView)
        
        toolbarSetup()

    }
    
    func toolbarSetup(){
        // warning을 막기 위해 임의로 위치와 크기를 잡아준다.
        let toolbar = UIToolbar(frame: .init(x: 0, y: 20, width: 100, height: 150))
        view.addSubview(toolbar)
        toolbar.barTintColor = .black

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true

        var items: [UIBarButtonItem] = []

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        let toolbarItem1 = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        toolbarItem1.tag = 1
       
        
        let toolbarItem2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapWriteButton))
        toolbarItem2.tag = 2
        
        let toolbarItem3 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapCalenderButton))
        toolbarItem3.tag = 3
        
        let toolbarItem4 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(didTapProfileButton))
        toolbarItem3.tag = 4
    
        items.append(toolbarItem1)
        items.append(flexibleSpace)
        items.append(toolbarItem2)
        items.append(flexibleSpace)
        items.append(toolbarItem3)
        items.append(flexibleSpace)
        items.append(toolbarItem4)

        items.forEach { (item) in
            item.tintColor = .orange
        }
        
        toolbar.setItems(items, animated: true)
    }
    
   

    
    private func setupTableView(){
       tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func didTapSearchButton(){
        print("select 1")
        let vc1 = SearchViewController()
        present(vc1, animated: true)
    }
    
    @objc func didTapWriteButton(){
        print("select 2")
        let vc2 = WriteViewController()
        present(vc2, animated: true)
    }
    
    @objc func didTapCalenderButton(){
        print("select 3")
        let vc3 = CalenderViewController()
        present(vc3, animated: true)
    }
    
    @objc func didTapProfileButton(){
        print("select 3")
        let vc4 = ProfileViewController()
        present(vc4, animated: true)
    }
    
    //frame
    override func viewDidLayoutSubviews() {
    
        scrollView.frame = view.bounds
        //글 무한 로딩 how ?
        contentCView.frame = CGRect(x: 0, y: 30, width: view.bounds.size.width, height: 3000)
        tableView.frame = CGRect(x: 20, y: 50, width: view.bounds.size.width - 70, height: 100)
   
    }
    
    @objc func didTapHome(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "showClub") else{
            return
        }
        let navVC = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("call tab bar")
//        switch item.tag  {
//        case 0:
//            print("1")
//            break
//        case 1:
//            print("2")
//            break
//        case 2:
//            print("3")
//            break
//        default:
//            print("else")
//        }
//    }
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }


}
