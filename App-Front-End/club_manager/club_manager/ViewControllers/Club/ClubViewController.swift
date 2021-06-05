//
//  ClubViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit
import TTGTagCollectionView

class ClubViewController: UIViewController, UIScrollViewDelegate, UITabBarControllerDelegate {
    var clubList: [Club] = []
    var recClubList: [Club] = []
    var filtered: [Club] = []
    var didTapTag = 1
    var clumName = ""
    
    var dataManager: DataManger?
    
    private var tagView: UIView = {
        let tagView = UIView()
        return tagView
    }()
    
    private let tagllection: TTGTextTagCollectionView = {
        let tagllection = TTGTextTagCollectionView()
        tagllection.alignment = .left
        let config = TTGTextTagConfig()
        config.backgroundColor = .systemGray2
        config.textColor = .white
        config.borderColor = .systemIndigo
        config.borderWidth = 1
        let tagName = ["여행", "스포츠/레저", "영화", "학술", "팬", "음악", "생활", "교육", "정치/사회"]
        tagllection.addTags(tagName, with: config)
        return tagllection
    }()
    
    @IBOutlet weak var myClubView: UIView!
    
    @IBOutlet weak var myNoteView: UIView!

    @IBOutlet weak var myRecView: UIView!

    @IBOutlet weak var myWaitView: UIView!
    
    @IBOutlet weak var myNoteTableView: UITableView!
    
    @IBOutlet weak var myClubCollectionView: UICollectionView!
    

    @IBOutlet weak var myAwiatCollectionView: UICollectionView!
    
    @IBAction func showAwaitButton(_ sender: Any) {
        print("have to connect awaitView")
    }
    
    var page = 0

    
    private var myRecTableview: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
//    private let waitView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 7
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor.gray.cgColor
//        let titleText = UILabel()
//        titleText.text = "승인 대기 클럽"
//        titleText.textAlignment = .center
//        titleText.font = .boldSystemFont(ofSize: 20)
//        titleText.frame = CGRect(x: 100, y: 10, width: 200, height: 30)
//
//        let button = UIButton()
//        button.setTitle("확인하기", for: .normal)
//        button.frame = CGRect(x: 120, y: titleText.bottom + 20, width: 200, height: 40)
//        button.addTarget(self, action: #selector(didTapWaitButton), for: .touchUpInside)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        button.backgroundColor = UIColor.black
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.black.cgColor
//
//        view.addSubview(titleText)
//        view.addSubview(button)
//
//        return view
//    }()
//
    
    var recScrollView : UIScrollView!
    
    let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        addClub()
    }

    func settingViewUI(){
        
        myClubView.layer.cornerRadius = 7
        myClubView.layer.borderWidth = 2
        myClubView.layer.borderColor = UIColor.gray.cgColor
        
        myNoteView.layer.cornerRadius = 7
        myNoteView.layer.borderWidth = 2
        myNoteView.layer.borderColor = UIColor.gray.cgColor
        
        myRecView.layer.cornerRadius = 7
        myRecView.layer.borderWidth = 2
        myRecView.layer.borderColor = UIColor.gray.cgColor
        
        myRecView.addSubview(tagllection)
        
        myWaitView.layer.cornerRadius = 7
        myWaitView.layer.borderWidth = 2
        myWaitView.layer.borderColor = UIColor.gray.cgColor
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewUI()
        page = 1
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.black

        let add = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(didAddClub))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target:self, action: #selector(didSearchClub))
        
        navigationItem.rightBarButtonItems = [add, search]
        settingDelegate()
        
    
        dataManager = DataManger()
        myRecView.addSubview(myRecTableview)
        myRecTableview.backgroundColor = .yellow
        myRecTableview.register(RecTableViewCell.nib(), forCellReuseIdentifier: RecTableViewCell.identifier)
        myNoteTableView.register(ClubNewsTableViewCell.nib(), forCellReuseIdentifier: ClubNewsTableViewCell.identifier)
    }
    

    func settingDelegate(){
        myNoteTableView.delegate = self
        myNoteTableView.dataSource = self
        tagllection.delegate = self
        myNoteTableView.delegate = self
        myNoteTableView.dataSource = self
        myAwiatCollectionView.dataSource = self
        myAwiatCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tagView.frame = CGRect(x: 0, y: 20, width: (view.width) * 2 - 40, height: 80)
        tagllection.frame = CGRect(x: 10, y: 10, width: view.width - 40, height: 40)
        tagllection.scrollDirection = .horizontal
        myRecTableview.frame = CGRect(x: 0, y: tagView.bottom + 10, width: myRecView.width, height: myRecView.height - (tagView.height + 50))
    
        recScrollView = UIScrollView(frame: CGRect(x: tagView.frame.minX, y: tagView.frame.minY + 10, width: (tagView.frame.size.width), height: tagView.frame.size.height))
        recScrollView.contentSize = CGSize(width: tagllection.width + 150, height: tagView.frame.size.height)
        recScrollView.showsHorizontalScrollIndicator = false
        
      
        makeLayout(layout: layout)
 
        myClubCollectionView!.delegate = self
        myClubCollectionView!.dataSource = self

        myClubCollectionView!.register(clubCollectionViewCell.nib(), forCellWithReuseIdentifier: clubCollectionViewCell.identifier)
        

        tagView.addSubview(tagllection)
        
        
        recScrollView.addSubview(tagView)
        myRecView.addSubview(recScrollView)
    }
    
    @objc func didTapWaitButton(){
        let waitVc = WaitViewController()
        self.navigationController?.pushViewController(waitVc, animated: true)
    }
    
    @objc func didAddClub(){
        //if user가 president -> can access
        //else
        let user:Int = 1;
        if user == 1 {
            //let addvc = AddClubViewController()
            let addVc = UIStoryboard.init(name: "AddClub", bundle: nil).instantiateViewController(identifier: "addClub")
            self.navigationController?.pushViewController(addVc, animated: true)
//            self.navigationController?.pushViewController(addvc, animated: true)
        }else {
            let accNot = UIAlertController(title: "접근 불가", message: "클럽 만들기는 클럽장만이 접근할 수 있습니다", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            accNot.addAction(okAction)
            present(accNot, animated: true, completion: nil)
        }
    }
    
    @objc func didSearchClub(){
        let searchvc = SearchClubViewController()
        self.navigationController?.pushViewController(searchvc, animated: true)
    }
    
    func makeLayout(layout: UICollectionViewFlowLayout){
        layout.scrollDirection = .horizontal
    }
    
    
    func addClub(){
        dataManager?.getAllClubs(clubs: "1") { result in
            self.clubList = result
            currentStatus.clubId = 1
            print(self.clubList)
            DispatchQueue.main.async {
                self.myRecTableview.reloadData()
                self.myClubCollectionView?.reloadData()
                self.myNoteTableView.reloadData()
            }
        }
       
        
    }
    
    func filterRecClubList(tag: String){
        filtered = self.recClubList.filter { $0.category == tag}
    }
}

extension ClubViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clubList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: clubCollectionViewCell.identifier, for: indexPath) as! clubCollectionViewCell
        cell.configure(with: self.clubList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mElementSize = CGSize(width: 100, height: 150)
            return mElementSize;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let homeView = self.segueTotabbar()
        homeView.titleName = self.clubList[indexPath.row].clubName
        currentStatus.clubId = self.clubList[indexPath.row].id
    
        present(tabBarViewController, animated: true, completion: nil)
    }
    
    func segueTotabbar() -> HomeViewController {
        let home = tabBarViewController.viewControllers![0] as! UINavigationController
        let search = tabBarViewController.viewControllers![1] as! UINavigationController
        let write = tabBarViewController.viewControllers![2] as! UINavigationController
        let calendar = tabBarViewController.viewControllers![3] as! UINavigationController
        let profile = tabBarViewController.viewControllers![4] as! UINavigationController
     
        tabBarViewController.setViewControllers([home, search, write, calendar, profile ], animated: true)
        tabBarViewController.modalPresentationStyle = .fullScreen
        return home.topViewController as! HomeViewController
    }

}

extension ClubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myNoteTableView {
            return self.clubList.count
        }else if tableView == myRecTableview {
            return filtered.count
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myNoteTableView.dequeueReusableCell(withIdentifier: ClubNewsTableViewCell.identifier) as! ClubNewsTableViewCell
        
        if tableView == myNoteTableView {
            cell.configure(with: self.clubList[indexPath.row])
            tableView.contentInset =  UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
            return cell
        }else if tableView == myRecTableview {
            let cellforRec = tableView.dequeueReusableCell(withIdentifier: RecTableViewCell.identifier) as! RecTableViewCell
            cellforRec.configure(with: filtered[indexPath.row])
            return cellforRec
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == myRecTableview {
            return 100
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == myNoteTableView {
            let homeView = self.segueTotabbar()
            homeView.titleName = self.clubList[indexPath.row].clubName
            present(tabBarViewController, animated: true, completion: nil)
        }else if (tableView == myRecTableview) {
//            let homeView = self.segueTotabbar()
//            homeView.titleName = self.clubList[indexPath.row].clubName
//            present(tabBarViewController, animated: true, completion: nil)
        }
    }
}

extension ClubViewController: TTGTextTagCollectionViewDelegate{
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
        return CGSize(width: 20, height: 10)
    }
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        textTagCollectionView.reload()
        didTapTag += 1
        
        //tag seleced
        if (didTapTag % 2 == 0){
            filterRecClubList(tag: tagText)
        }else {
            filtered = self.recClubList
        }
        myRecTableview.reloadData()
    }

}



