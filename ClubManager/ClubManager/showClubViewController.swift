//
//  showClubViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/20.
//

import UIKit


class showClubViewController: UIViewController {
    
    var numberOfCell: Int = 4
    let data = ["공지사항1", "공지사항2"]
    private let myClubLabel: UILabel = {
        let myClubLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        myClubLabel.text = "내 동아리"
        myClubLabel.backgroundColor = .blue
        myClubLabel.textColor = .black
        return myClubLabel
    }()
    
    private let contentCView: UIView = {
        let contentCView = UIView()
        contentCView.backgroundColor = .green
        return contentCView
    }()
    
    private let myClubView: UIView = {
        let myClubView = UIView()
        myClubView.backgroundColor = .brown
        return myClubView
    }()
    
    
    private let myNews: UIView = {
        let myNews = UIView()
        myNews.backgroundColor = .yellow
        return myNews
    }()
    
    private let recClub: UIView = {
        let recClub = UIView()
        recClub.backgroundColor = .orange
        return recClub
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .blue
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var collectionView: UICollectionView?
    
    var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Club"
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10 // 아이템간 최소 거리
        layout.minimumInteritemSpacing = 10 // 아이템 행간 최소 거리
        layout.sectionInset = UIEdgeInsets(top: 100, left: 20, bottom: 20, right: 20)
        
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = .purple
      
        collectionView.allowsSelection = true
        
        
        collectionView.isUserInteractionEnabled = true
        contentCView.isUserInteractionEnabled = true
        //layout.itemSize = CGSize(width: (collectionView.width/4), height: (collectionView.height/2))
        
        setUpMyClub()
        setUpNews()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: screenWidth, height: (scrollView.width * 3) + 20)
        
        contentCView.addSubview(collectionView)
        collectionView.addSubview(myClubLabel)
        contentCView.addSubview(myNews)
        contentCView.addSubview(recClub)
        
        myNews.addSubview(tableView)
        
        scrollView.addSubview(contentCView)
        view.addSubview(scrollView)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        contentCView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 2000)
        collectionView!.frame = CGRect(x: 10, y: 40, width: contentCView.width - 20, height: contentCView.width - 20)


        myNews.frame = CGRect(x: 10, y: collectionView!.bottom + 20, width: contentCView.width - 20, height: contentCView.width - 20)
        
        tableView.frame = CGRect(x: 10, y: 10, width: contentCView.width - 40, height: contentCView.width - 40)
        
        recClub.frame = CGRect(x:10, y: myNews.bottom + 20, width: contentCView.width - 20, height: contentCView.width - 20)
    }
    
    func setUpMyClub(){
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    func setUpNews(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
 
}
extension showClubViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
        cell.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click the cell")

        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "home"))!
        self.navigationController?.pushViewController(vc, animated: true)
    
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! UITabBarController
//        UIApplication.shared.windows.first?.rootViewController = vc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
//
//        if let clubVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
//            //self.modalPresentationStyle = .automatic
//            present(clubVC, animated: true, completion: nil)
//        }
//
        //self.navigationController?.pushViewController(madCampVC!, animated: true)
    }
}

extension showClubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
}
