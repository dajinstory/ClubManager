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
    
    private let contentView: UIView = {
        let contentCView = UIView()
        return contentCView
    }()
    
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
    
    private var clubView: UIView = {
        let clubView = UIView()
        
        clubView.layer.cornerRadius = 7
        clubView.layer.borderWidth = 2
        clubView.layer.borderColor = UIColor.gray.cgColor

        let titleText = UILabel()
        titleText.text = "Club"
        titleText.textAlignment = .left
        titleText.font = .boldSystemFont(ofSize: 20)
        titleText.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        clubView.addSubview(titleText)
        return clubView
    }()
    
    private var clubNewsView: UIView = {
        let clubNewsView = UIView()
        clubNewsView.layer.cornerRadius = 7
        clubNewsView.layer.borderWidth = 2
        clubNewsView.layer.borderColor = UIColor.gray.cgColor
        let titleText = UILabel()
        titleText.text = "공지사항"
        titleText.textAlignment = .left
        titleText.font = .boldSystemFont(ofSize: 20)
        titleText.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        clubNewsView.addSubview(titleText)
        
        return clubNewsView
    }()
    
    private var recommendView: UIView = {
        let recommendView = UIView()
        recommendView.layer.cornerRadius = 7
        recommendView.layer.borderWidth = 2
        recommendView.layer.borderColor = UIColor.gray.cgColor
        let titleText = UILabel()
        titleText.text = "이런 동아리는 어때요?"
        titleText.textAlignment = .left
        titleText.font = .boldSystemFont(ofSize: 20)
        titleText.frame = CGRect(x: 10, y: 10, width: 200, height: 30)
        
        recommendView.addSubview(titleText)
        return recommendView
    }()
    
    private let rectableView: UITableView = {
        let rectableView = UITableView()
        rectableView.register(RecTableViewCell.nib(), forCellReuseIdentifier: RecTableViewCell.identifier)
        return rectableView
    }()
    
    var contentOffset:CGFloat = 0
    var page = 0
    var clubNewsTableView: UITableView =  {
        var clubNewsTableView = UITableView()
        clubNewsTableView.register(ClubNewsTableViewCell.nib(), forCellReuseIdentifier: ClubNewsTableViewCell.identifier)
        clubNewsTableView.isPagingEnabled = true
        return clubNewsTableView
    }()
    
    private let waitView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        let titleText = UILabel()
        titleText.text = "승인 대기 클럽"
        titleText.textAlignment = .center
        titleText.font = .boldSystemFont(ofSize: 20)
        titleText.frame = CGRect(x: 100, y: 10, width: 200, height: 30)
      
        let button = UIButton()
        button.setTitle("확인하기", for: .normal)
        button.frame = CGRect(x: 100, y: titleText.bottom + 20, width: 200, height: 30)
        button.addTarget(self, action: #selector(didTapWaitButton), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue.cgColor
        
        view.addSubview(titleText)
        view.addSubview(button)
        
        return view
    }()
    
    
    var scrollView: UIScrollView!
    var recScrollView : UIScrollView!
    
    let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1
        view.backgroundColor = .white

        let add = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(didAddClub))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target:self, action: #selector(didSearchClub))
        
        navigationItem.rightBarButtonItems = [add, search]
        settingDelegate()
        addClubList()
        addrecClub()
        findClub()
        
        contentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 2000)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: (scrollView.width * 3) + 150)
    }
    
    func findClub(){
        print(self.clubList.count)
        print("findClub")
        for i in self.clubList{
            print("\(i.category) \(i.clubImage)")
        }
    }
    
    func settingDelegate(){
        clubNewsTableView.delegate = self
        clubNewsTableView.dataSource = self
        tagllection.delegate = self
        rectableView.delegate = self
        rectableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clubView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 200)
        clubNewsView.frame = CGRect(x: 0, y: clubView.bottom + 5, width: contentView.width, height: 500)
        recommendView.frame = CGRect(x: 0, y: clubNewsView.bottom + 5, width: contentView.width, height: 500)
        waitView.frame = CGRect(x: 0, y: recommendView.bottom, width: contentView.width, height: 100)
        clubNewsTableView.frame = CGRect(x: 0, y: 50, width: contentView.width, height: clubNewsView.height - 60)
        clubNewsTableView.backgroundColor = .red
//        clubNewsTableView.layoutMargins = UIEdgeInsets(top: 0,
//                                                       left: 30,
//                                                       bottom: 0,
//                                                       right: 30)
        
        tagView.frame = CGRect(x: 0, y: 20, width: (contentView.width) * 2, height: 80)
        tagllection.frame = CGRect(x: 10, y: 10, width: tagView.width, height: 40)
        tagllection.scrollDirection = .horizontal
        
        rectableView.frame = CGRect(x: 0, y: tagView.bottom, width: contentView.width, height: recommendView.height - (tagView.height + 20))
    
        recScrollView = UIScrollView(frame: CGRect(x: tagView.frame.minX, y: tagView.frame.minY + 10, width: (tagView.frame.size.width), height: tagView.frame.size.height))
        recScrollView.contentSize = CGSize(width: tagllection.width + 150, height: tagView.frame.size.height)
        recScrollView.showsHorizontalScrollIndicator = false
        
        let clubCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        makeLayout(layout: layout)
        clubCollectionView.delegate = self
        clubCollectionView.dataSource = self
        clubCollectionView.backgroundColor = .red
        clubCollectionView.frame = CGRect(x: 10, y: 40, width: contentView.width - 10 , height: 160)
        clubCollectionView.register(clubCollectionViewCell.nib(), forCellWithReuseIdentifier: clubCollectionViewCell.identifier)
        
        
        //clubCollectionView.backgroundColor = .clear

        
        contentView.addSubview(clubView)
        clubView.addSubview(clubCollectionView)
        contentView.addSubview(clubNewsView)
        clubNewsView.addSubview(clubNewsTableView)
        contentView.addSubview(recommendView)
        contentView.addSubview(waitView)
        
        recommendView.addSubview(tagView)
        recommendView.addSubview(rectableView)
        tagView.addSubview(tagllection)
        recScrollView.addSubview(tagView)
        recommendView.addSubview(recScrollView)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    @objc func didTapWaitButton(){
        let waitVc = WaitViewController()
        self.navigationController?.pushViewController(waitVc, animated: true)
    }
    
    @objc func didAddClub(){
        let addvc = AddClubViewController()
        self.navigationController?.pushViewController(addvc, animated: true)
    }
    
    @objc func didSearchClub(){
        let searchvc = SearchClubViewController()
        self.navigationController?.pushViewController(searchvc, animated: true)
    }
    
    func makeLayout(layout: UICollectionViewFlowLayout){
        layout.scrollDirection = .horizontal
    }
    
    func getMyClubs(clubs: String, completionHandler: @escaping (_ result: Data) -> ()) {
        // check user if already registered
        let url_URL = URL(string: "http://13.124.135.59:47000/club")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
        request.setValue(clubs, forHTTPHeaderField: "clubs")

        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data=data, let dataString = String(data: data, encoding: .utf8) {
                
                print("[Rest API] getMyClubs : \(dataString)")
                completionHandler(data)

            }
        }
        task.resume()
    }
    
    func getAllClubs(completionHandler: @escaping (_ result: Data) -> ()) {
        // check user if already registered
        let url_URL = URL(string: "http://13.124.135.59:47000/club")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
       
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data=data, let dataString = String(data: data, encoding: .utf8) {
                
                print("[Rest API] getAllClubs : \(dataString)")
                completionHandler(data)

            }
        }
        task.resume()
    }
    
    func addClubList(){
        getMyClubs(clubs: "1,2") {
            result in
    
            do {
                if let clubs = try JSONSerialization.jsonObject(with: result) as? [Dictionary<String, Any>] {
                    for club in clubs {
                        guard let id = club["id"] as? Int64 else {
                            return
                        }
                        guard let president = club["president"] as? Int64 else {
                            return
                        }
                        guard let name = club["name"] as? String else {
                            return
                        }
                        guard let summary = club["clubSummary"] as? String else {
                            return
                        }
                        guard let category = club["category"] as? String else {
                            return
                        }
                        
                        let newClub = Club(
                            id: id,
                            president: president,
                            clubImage:  "image1",
                            clubName: name,
                            clubSummary: summary,
                            category: "생활",
                            note1: "야호")
                        print("newClub  \(newClub)")
                    
                        self.clubList.append(newClub)
                    }
   
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }

    
    func addrecClub(){
        getAllClubs() {
            result in
    
            do {
                if let clubs = try JSONSerialization.jsonObject(with: result) as? [Dictionary<String, Any>] {
                    for club in clubs {
                        guard let id = club["id"] as? Int64 else {
                            return
                        }
                        guard let president = club["president"] as? Int64 else {
                            return
                        }
                        guard let name = club["name"] as? String else {
                            return
                        }
                        guard let summary = club["clubSummary"] as? String else {
                            return
                        }
                        guard let category = club["category"] as? String else {
                            return
                        }
                        
                        let newClub = Club(
                            id: id,
                            president: president,
                            clubImage:  "image1",
                            clubName: name,
                            clubSummary: summary,
                            category: "생활",
                            note1: "야호")
                    
                        self.recClubList.append(newClub)
                    }
   
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        filtered = self.recClubList
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
        print(self.clubList[indexPath.row])
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
        if tableView == clubNewsTableView {
            return self.clubList.count
        }else if tableView == rectableView {
            return filtered.count
        }
        return 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clubNewsTableView.dequeueReusableCell(withIdentifier: ClubNewsTableViewCell.identifier) as! ClubNewsTableViewCell
        
        if tableView == clubNewsTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: ClubNewsTableViewCell.identifier) as! ClubNewsTableViewCell
            cell.configure(with: self.clubList[indexPath.row])
            tableView.contentInset =  UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
//            cell.leftInset = 100
//            cell.rightInset = 100
//            cell.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
            return cell
        }else if tableView == rectableView {
            let cellforRec = tableView.dequeueReusableCell(withIdentifier: RecTableViewCell.identifier) as! RecTableViewCell
            cellforRec.configure(with: filtered[indexPath.row])
            return cellforRec
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rectableView {
            return 100
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == clubNewsTableView {
            let homeView = self.segueTotabbar()
            homeView.titleName = self.clubList[indexPath.row].clubName
            present(tabBarViewController, animated: true, completion: nil)
        }else if (tableView == rectableView) {
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
        rectableView.reloadData()
    }

}



