//
//  ClubViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit
import TTGTagCollectionView

struct club {
    var clubImage: String
    var clubName: String
}

struct recClub {
    var clubImage: String
    var clubName: String
    var clubSummary: String
    var category: String
}

class ClubViewController: UIViewController, UIScrollViewDelegate {
    var clubList: [club] = []
    var recClubList: [recClub] = []
    var filtered: [recClub] = []
    var didTapTag = 1
    
    private var newsData = [NewsData]()
    
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
    
    var clubNewsTableView: UITableView =  {
        var clubNewsTableView = UITableView()
        clubNewsTableView.register(ClubNewsTableViewCell.nib(), forCellReuseIdentifier: ClubNewsTableViewCell.identifier)
//        clubNewsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return clubNewsTableView
    }()
    
    
    
    var scrollView: UIScrollView!
    var recScrollView : UIScrollView!
    
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(didAddClub))
        
        clubNewsTableView.delegate = self
        clubNewsTableView.dataSource = self
        
        tagllection.delegate = self
        
        rectableView.delegate = self
        rectableView.dataSource = self
        
        
        addClubList()
        addNewsData()
        //후에 json 으로 만들기
        addrecClub()
        
        contentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 2000)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: (scrollView.width * 3) + 20)
        //scrollView.backgroundColor = .systemOrange
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clubView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 200)
        clubNewsView.frame = CGRect(x: 0, y: clubView.bottom + 5, width: contentView.width, height: 500)
        recommendView.frame = CGRect(x: 0, y: clubNewsView.bottom + 5, width: contentView.width, height: 500)
        clubNewsTableView.frame = CGRect(x: 0, y: 40, width: contentView.width, height: clubNewsView.height - 50)
        
        tagView.frame = CGRect(x: 0, y: 20, width: (contentView.width) * 2, height: 80)
        //tagView.backgroundColor = .systemPink
        tagllection.frame = CGRect(x: 10, y: 10, width: tagView.width, height: 40)
        tagllection.scrollDirection = .horizontal
        
        rectableView.frame = CGRect(x: 0, y: tagView.bottom, width: contentView.width, height: recommendView.height - (tagView.height + 20))
        
        
        print("rec : \(tagView.bounds) and \(tagView.frame)")
        recScrollView = UIScrollView(frame: CGRect(x: tagView.frame.minX, y: tagView.frame.minY + 10, width: (tagView.frame.size.width), height: tagView.frame.size.height))
        print("reecc : \(tagView.frame.size.width) and \(tagView.frame.size.height)")
        recScrollView.contentSize = CGSize(width: tagllection.width + 150, height: tagView.frame.size.height)
        recScrollView.showsHorizontalScrollIndicator = false
        //recScrollView.backgroundColor = .blue
        
        
        
        let clubCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        makeLayout(layout: layout)
        clubCollectionView.delegate = self
        clubCollectionView.dataSource = self
        
        clubCollectionView.frame = CGRect(x: 10, y: 50, width: contentView.width - 10 , height: 150)
        clubCollectionView.register(clubCollectionViewCell.nib(), forCellWithReuseIdentifier: clubCollectionViewCell.identifier)
        
        
        clubCollectionView.backgroundColor = .clear

        
        contentView.addSubview(clubView)
        clubView.addSubview(clubCollectionView)
        contentView.addSubview(clubNewsView)
        clubNewsView.addSubview(clubNewsTableView)
        contentView.addSubview(recommendView)
        
        recommendView.addSubview(tagView)
        recommendView.addSubview(rectableView)
        tagView.addSubview(tagllection)
        recScrollView.addSubview(tagView)
        recommendView.addSubview(recScrollView)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    @objc func didAddClub(){
        print("did tap add club bar button");
    }
    
    func makeLayout(layout: UICollectionViewFlowLayout){
        layout.scrollDirection = .horizontal
    }
    
    func addClubList(){
        clubList.append(club(clubImage: "image1", clubName: "몰입 캠프"))
        clubList.append(club(clubImage: "image2", clubName: "힐링 모임"))
        clubList.append(club(clubImage: "image3", clubName: "흰소다"))
        clubList.append(club(clubImage: "image4", clubName: "week5"))
        clubList.append(club(clubImage: "image5", clubName: "고독한 캠프"))
        clubList.append(club(clubImage: "image6", clubName: "강사모"))
        clubList.append(club(clubImage: "image7", clubName: "등산 모임"))
        
    }
    
    func addNewsData(){
        newsData.append(NewsData(profileImage: "image1", title: "몰입 캠프", content: "공지사항입니다 ~~"))
        newsData.append(NewsData(profileImage: "image2", title: "힐링 모임", content: "공지사항입니다 ~~"))
        newsData.append(NewsData(profileImage: "image3", title: "흰소다", content: "공지사항입니다 ~~"))
        newsData.append(NewsData(profileImage: "image4", title: "week5", content: "공지사항입니다 ~~"))
        newsData.append(NewsData(profileImage: "image5", title: "고독한 캠프", content: "공지사항입니다 ~~"))
        newsData.append(NewsData(profileImage: "image6", title: "강사모", content: "공지사항입니다 ~~"))
        newsData.append(NewsData(profileImage: "image7", title: "등산 모임", content: "공지사항입니다 ~~"))
        
    }
    
    func addrecClub(){
        recClubList.append(recClub(clubImage: "totoro", clubName: "영화 모임", clubSummary: "영화를 소개하고 영화를 같이 보는 모임입니다", category: "영화"))
        recClubList.append(recClub(clubImage: "fcSeoul", clubName: "fc 서울", clubSummary: "fcSeoul 축구의 공식 동아리입니다.", category: "스포츠/레저"))
        recClubList.append(recClub(clubImage: "aa", clubName: "얼죽아", clubSummary: "얼어 죽어도 아이스 아메리카노를 외치는 모임입니다", category: "생활"))
        recClubList.append(recClub(clubImage: "shinee1", clubName: "샤월 모여라", clubSummary: "샤이니를 좋아하는 사람들끼리 수다를 떠는 모임입니다.", category: "팬"))
        filtered = recClubList
    }
    
    func filterRecClubList(tag: String){
        print("filter")
        filtered = recClubList.filter { $0.category == tag}
        //print(filtered)
    }
    


}

extension ClubViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clubList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: clubCollectionViewCell.identifier, for: indexPath) as! clubCollectionViewCell
        cell.configure(with: clubList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mElementSize = CGSize(width: 100, height: 150)
            return mElementSize;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //tabBarViewController를 initial로 만들기
        let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController

        //print(clubList[indexPath.row].clubName)
        
        //homeview의 navigationController
        let homeViewController = tabBarViewController.viewControllers?[0]
        
        homeViewController?.navigationItem.title = clubList[indexPath.row].clubName
        view.window?.rootViewController = tabBarViewController
              view.window?.makeKeyAndVisible()
        
    
    }
    
    
    
}

extension ClubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == clubNewsTableView {
            return newsData.count
        }else if tableView == rectableView {
            return filtered.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clubNewsTableView.dequeueReusableCell(withIdentifier: ClubNewsTableViewCell.identifier) as! ClubNewsTableViewCell
        
        if tableView == clubNewsTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: ClubNewsTableViewCell.identifier) as! ClubNewsTableViewCell
            cell.configure(with: newsData[indexPath.row])
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
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
            let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController

            view.window?.rootViewController = tabBarViewController
                  view.window?.makeKeyAndVisible()
        }else if (tableView == rectableView) {
            let tabBarViewController = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as! UITabBarController

            view.window?.rootViewController = tabBarViewController
                  view.window?.makeKeyAndVisible()
        }
    }
    
    
}

extension ClubViewController: TTGTextTagCollectionViewDelegate{
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
        return CGSize(width: 20, height: 10)
    }
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        textTagCollectionView.reload()
        //print(tagText!)
        didTapTag += 1
        
        //tag seleced
        if (didTapTag % 2 == 0){
            filterRecClubList(tag: tagText)
        }else {
            filtered = recClubList
        }
        rectableView.reloadData()
    }

}


struct Constants {

struct Storyboard {

    static let homeViewController = "HomeVC"

    static let tabBarController = "HomeTVC"

    static let mainStoryBoard = "Main"
}
}
