//
//  HomeViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit

struct cellData{
    let userName: String
    let title:String
    let content:String
}

struct NewsData{
    var profileImage: String
    var title: String
    var content: String
}


class HomeViewController: UIViewController {
    
    var transparentView = UIView()
    var tableViewM = UITableView()
    var settingArray = ["Profile","Favorite","Notification","Change Password","Logout"]
    
    private var data = [cellData]()
    
    
    var isPaging:Bool = false
    var hasNextPage: Bool = false
    
    let height: CGFloat = 250
    

    //menu button
    @objc func onClickMenu() {
        
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)

        let screenSize = UIScreen.main.bounds.size
        tableViewM.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
        window?.addSubview(tableViewM)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewM.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: self.height)
        }, completion: nil)
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewM.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.height)
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(didTapHome))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(onClickMenu))
    
        view.addSubview(tableView1)
  
        //toolbarSetup()
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
        print("create spinner")
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
            let model = data[indexPath.row]
            let cellforTableView1 = tableView.dequeueReusableCell(withIdentifier: AllNoteTableViewCell.identifier, for: indexPath) as! AllNoteTableViewCell
            cellforTableView1.configure(with: model)
            return cellforTableView1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    //테이블에 출력될 데이터 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return data.count
        }else if section == 1 && isPaging && hasNextPage {
            return 1
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
//        let vc = detalHomeViewController()
//        present(vc, animated: true, completion: nil)
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
    
    func paging(){
        let index = data.count
        var datas: [cellData] = []
        for i in index ..< (index + 20){
            let data = cellData(userName: "username\(i)", title: "title:\(i)", content: "content\(i)")
            datas.append(data)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            self.tableView1.tableFooterView = nil
            
            self.data.append(contentsOf: datas)
            self.hasNextPage = self.data.count > 300 ? false: true
            self.isPaging = false
            self.tableView1.reloadData()
        }
    }

    }


