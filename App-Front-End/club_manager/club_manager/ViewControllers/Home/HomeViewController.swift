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
    var settingArray = ["Profile","Favorite","Notification","Change Password","Logout"]
    
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
        tableViewM.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 250)
        window?.addSubview(tableViewM)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewM.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 250)
        }, completion: nil)
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewM.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 250)
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
        navigationItem.title = titleName
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(didTapHome))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(onClickMenu))
    
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
        tableViewM.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    private func createSpinnerFooter() -> UIView {
        //print("create spinner")
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.startAnimating()
        return footerView
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewM {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = settingArray[indexPath.row]
            return cell
        } else if tableView == tableView1 {
            //print("here")
            let modelBoard = data[indexPath.row]
            //print(modelBoard)
            let modelUser = user[indexPath.row]
            //print(modelUser)
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
            return 50
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
        
        let vc = DetailBoardViewController()
        let userName = user[indexPath.row].userName
        let dateForDate = data[indexPath.row].date
        
        let title = data[indexPath.row].title
        let content = data[indexPath.row].content
        vc.note.append(BoardData(BoardCategory: ["전체글"], title: title, content: content, comment: ["좋은 정보 감사합니다", "확인했어요"], count: 1, date: dateForDate))
        vc.userData.append(User(id: 1, userImage: "person.crop.circle", userName: userName, userEmail: ""))
        //detailView show시 tabbar hide
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "전체 글"
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

           
   func beginPaging() {
       isPaging = true // 현재 페이징이 진행 되는 것을 표시

       // 페이징 메소드 호출
       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           self.paging()
       }
   }
    
    func paging() {
        //print("func paging called")
        let index = data.count
        let dataFormatter = DateFormatter()
        
        var datas: [BoardData] = []
        for i in index ..< (index + 20){
            let dateNow = dataFormatter.date(from: "2021.04.1\(i) 21:09")
            let data = BoardData(BoardCategory: ["전체글"], title: "title:\(i)", content: "content\(i) content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)content\(i)", comment: ["좋은 글 감사합니다.", "확인 완료"], count: 1, date: dateNow ?? Date())
            datas.append(data)
            user.append(User(id: 1, userImage: "person.crop.circle", userName: "조소정", userEmail: ""))
        }
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            self.tableView1.tableFooterView = nil
            self.data.append(contentsOf: datas)
            self.hasNextPage = self.data.count > 50 ? false: true
            self.isPaging = false
            self.tableView1.reloadData()
        }
    }

    }


