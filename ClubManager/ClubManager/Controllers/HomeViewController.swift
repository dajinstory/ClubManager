//
//  ClubViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/21.
//
//
import UIKit

struct cellData{
    let title:String
    let content:String
}

//class LoadingCell : UITableViewCell {
//    func start(){
//        acti
//    }
//}

class HomeViewController: UIViewController, UIToolbarDelegate {
    
    var transparentView = UIView()
    var tableViewM = UITableView()
    var settingArray = ["Profile","Favorite","Notification","Change Password","Logout"]
    
    private var data = [cellData]()
    var isPaging:Bool = false
    var hasNextPage: Bool = false
    
    let height: CGFloat = 250
    

    //menu button
    @IBAction func onClickMenu(_ sender: Any) {
        
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
    
    
    
    let toolbar = UIToolbar()

    
    private let tableView1: UITableView = {
        let table = UITableView()
        table.register(CustomNoteTableViewCell.self, forCellReuseIdentifier: CustomNoteTableViewCell.identifier)
        return table
    }()
    
    //var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        paging()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let screensize: CGRect = UIScreen.main.bounds
//        let screenWidth = screensize.width
//        let screenHeight = screensize.height
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(didTapHome))
        
        //contentCView.isUserInteractionEnabled = true
        
//        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        scrollView.clipsToBounds = true
//        scrollView.contentSize = CGSize(width: screenWidth, height: (scrollView.width * 3) + 20)
//        //scrollView.addSubview(contentCView)
//        //contentCView.addSubview(tableView1)
//        view.addSubview(scrollView)
        view.addSubview(tableView1)
  
        toolbarSetup()
        setupMenu()
        setupTableView()
    }
    
    //frame
    override func viewDidLayoutSubviews() {

        //scrollView.frame = view.bounds
        //contentCView.frame = CGRect(x: 0, y: 30, width: view.bounds.size.width, height: 3000)
        tableView1.frame = view.bounds
            //CGRect(x: 10 , y: 30, width: view.bounds.size.width, height: view.bounds.size.height - 10)
        
        
//        apiCaller.fetchData(completion: { [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.data.append(contentsOf: data)
//
//                DispatchQueue.main.async {
//                    self?.tableView1.reloadData()
//                }
//
//            case .failure(_):
//                break
//            }})
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    

    //toolbar move
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
    
    @objc func didTapHome(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "showClub") else{
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
            let cellforTableView1 = tableView.dequeueReusableCell(withIdentifier: CustomNoteTableViewCell.identifier, for: indexPath) as! CustomNoteTableViewCell
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

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewM {
            return 50
        }else if tableView == tableView1 {
            return 70
        }
        //default
        return 10
      
        
    }
    
    //pagination 처리
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        //print("position : \(position) contentHeight : \(contentHeight) height : \(height)")
               
       // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
       if position > (contentHeight - height) {
        print("call cause position is more than")
           if isPaging == false && hasNextPage {
               beginPaging()
           }
       }

    }

           
   func beginPaging() {
       isPaging = true // 현재 페이징이 진행 되는 것을 표시
       // Section 1을 reload하여 로딩 셀을 보여줌 (페이징 진행 중인 것을 확인할 수 있도록)
//        DispatchQueue.main.async {
//            self.tableView1.reloadSections(IndexSet(integer: 1), with: .none)
//        }

       
       // 페이징 메소드 호출
       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           self.paging()
       }
   }
    
    func paging(){
        let index = data.count
        var datas: [cellData] = []
        for i in index ..< (index + 20){
            let data = cellData(title: "title:\(i)", content: "content\(i)")
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

//
//        if position > (tableView1.contentSize.height - 100 - scrollView.frame.size.height) {
//            guard !apiCaller.isPaginating else {
//
//                //we are already fetching more data
//                return
//            }
//
//            apiCaller.fetchData(pagination: true){ [weak self] result in
//                DispatchQueue.main.async {
//                    self?.tableView1.tableFooterView = nil
//                }
//
//                switch result {
//                case .success(let moreData):
//                    self?.data.append(contentsOf: moreData)
//                    DispatchQueue.main.async {
//                        self?.tableView1.reloadData()
//                    }
//                    case .failure(_):
//                        break;
//                    }
//
//                }
//
//        }
// 
    }



