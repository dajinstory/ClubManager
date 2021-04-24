//
//  HomeViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit

class HomeViewController: UIViewController {
    var titleName: String = ""
    var transparentView = UIView()
    var tableViewM = UITableView()
    var settingArray = ["전체글","공지사항", "T/F 회의록","결산 내역"]
    
    
    private var data = [BoardData]()
    private var user = [User]()
    
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    

    //menu button
    @objc func onClickMenu() {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)

        let screenSize = UIScreen.main.bounds.size
        tableViewM.frame = CGRect(x: 0, y: 100, width: screenSize.width, height: 500)
        window?.addSubview(tableViewM)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewM.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 500)
        }, completion: nil)
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewM.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 0)
        }, completion: nil)
    }

    
    private let tableView1: UITableView = {
        let table = UITableView()
        table.register(AllNoteTableViewCell.nib(), forCellReuseIdentifier: AllNoteTableViewCell.identifier)
        return table
    }()
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        paging()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = titleName

        
        let homeImage = UIImage(systemName: "house.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: homeImage, style: .plain, target: self, action: #selector(didTapHome))
       
        
        
        let img = UIImage(named: "hamburger_32px")!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .done, target: self, action: #selector(onClickMenu))
    
        view.addSubview(tableView1)

        setupMenu()
        setupTableView()
    }
    
    
    
    //frame
    override func viewDidLayoutSubviews() {
        tableView1.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupMenu(){
        tableViewM.isScrollEnabled = true
        tableViewM.delegate = self
        tableViewM.dataSource = self
        tableViewM.register(MenuTableViewCell.nib(), forCellReuseIdentifier:MenuTableViewCell.idenfifier)
    }
    
    private func setupTableView(){
       tableView1.delegate = self
        tableView1.dataSource = self
    }
    


    
    @objc func didTapHome(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "Club") else{
            return
        }
        let navVC = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewM {
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.idenfifier, for: indexPath) as! MenuTableViewCell
            cell.textMenu.text = settingArray[indexPath.row]
            cell.configure()
            return cell
        } else if tableView == tableView1 {
            let modelBoard = data[indexPath.row]
            let modelUser = user[indexPath.row]
            let cellforTableView1 = tableView.dequeueReusableCell(withIdentifier: AllNoteTableViewCell.identifier, for: indexPath) as! AllNoteTableViewCell
            cellforTableView1.configure(with: modelBoard, modelUser: modelUser)
            return cellforTableView1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    //테이블에 출력될 데이터 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewM {
            return settingArray.count
        }else if tableView == tableView1 {
            if(section == 0){
                return data.count
            }else if section == 1 && isPaging && hasNextPage {
                return 1
            }
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableView1 {
            return 150
        }
        return 50
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewM {
            return 100
        }else if tableView == tableView1 {
            return 150
        }
        //default
        return 10
      
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let lastSectionIndex = tableView.numberOfSections - 1
       let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
       if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
        if (tableView == tableView1){
            let spinner = UIActivityIndicatorView(style: .medium)
               spinner.startAnimating()
               spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            tableView1.tableFooterView = spinner
            tableView1.tableFooterView?.isHidden = false
           }
        }
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == tableView1){
            let vc = DetailBoardViewController()
            let userName = user[indexPath.row].userName
            let dateForDate = data[indexPath.row].date
            
            let title = data[indexPath.row].title
            let content = data[indexPath.row].content
            vc.note.append(BoardData(BoardCategory: "전체글", title: title, content: content, comment: ["좋은 정보 감사합니다", "확인했어요"], count: 1, date: dateForDate))
            vc.userData.append(User(id: 1, userImage: "person.crop.circle", userName: userName, userEmail: ""))
            //detailView show시 tabbar hide
            vc.hidesBottomBarWhenPushed = true

            self.navigationController?.pushViewController(vc, animated: true)
        }else if (tableView == tableViewM){
            
            print("tableview menu click")
        }
       
    }
    
    
    //for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableView1{
            return "전체 글"
        }else {
            return ""
        }
       
    }
    
    
    //pagination 처리
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
       // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
       if position > (contentHeight - height) {
           if isPaging == false && hasNextPage {
               beginPaging()
           }
       }

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(hasNextPage == false){
            print("here")
            tableView1.tableFooterView = nil
        }
    }

           
   func beginPaging() {
       isPaging = true // 현재 페이징이 진행 되는 것을 표시
       // 페이징 메소드 호출
       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           self.paging()
       }
   }
    
    func paging() {
        let index = data.count
        var datas: [BoardData] = []
        
        for i in index ..< (index + 20){
            let dataLoop = Dummy.shared.Boards(board: data)
            let userLoop = Dummy.shared.Users(user: user)
            datas.append(contentsOf: dataLoop)
            user.append(contentsOf: userLoop)
            
        }
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView1.tableFooterView = nil
            self.data.append(contentsOf: datas)
            self.hasNextPage = self.data.count > 30 ? false: true
            self.isPaging = false
            self.tableView1.reloadData()
        }
    }

    }


