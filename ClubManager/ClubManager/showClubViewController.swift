//
//  showClubViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/20.
//

import UIKit

//myClubView 위에 pageControl이랑 scrollview 올리기
class showClubViewController: UIViewController, UIScrollViewDelegate {
    var pageSize : Int = 4;
    var numberOfCell: Int = 8
    
    
    let data = ["공지사항1", "공지사항2"]
    
    private let contentCView: UIView = {
        let contentCView = UIView()
        //contentCView.backgroundColor = .green
        return contentCView
    }()
    var scrollView: UIScrollView!
    
    private let myClubLabel: UILabel = {
        let myClubLabel = UILabel()
        myClubLabel.text = "내 동아리"
        myClubLabel.backgroundColor = .blue
        myClubLabel.textColor = .black
        return myClubLabel
    }()
    

    private var myClubView: UIView = {
        let myClubView = UIView()
        myClubView.backgroundColor = .brown
        return myClubView
    }()
    
    
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    

    
    private var scrollViewForColl: UIScrollView = {
        let scrollViewForColl = UIScrollView()

        scrollViewForColl.showsHorizontalScrollIndicator = false
        scrollViewForColl.showsVerticalScrollIndicator = false
        scrollViewForColl.isPagingEnabled = true
        scrollViewForColl.backgroundColor = .blue
        scrollViewForColl.contentSize = CGSize(width: CGFloat(4) * UIScreen.main.bounds.width, height: 0)
        return scrollViewForColl
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

    
    //공지사항
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .blue
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
   
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Club"
        
//        let screensize: CGRect = UIScreen.main.bounds
//        let screenWidth = screensize.width
//        let screenHeight = screensize.height
        contentCView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 2000)

        let width = view.frame.maxX

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //cell layout의 위치
        layout.sectionInset = UIEdgeInsets(top: myClubLabel.bottom + 20, left: 30, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 50 // 아이템 라인간 최소 거리
        layout.minimumInteritemSpacing = 20 // 아이템 행간 최소 거리
        layout.scrollDirection = .vertical
        
        let layoutForNews: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: myNews.top + 20, left: 30, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: 80, height: 80)
        //layout.minimumLineSpacing = 50 // 아이템 라인간 최소 거리
        //layout.minimumInteritemSpacing = 20 // 아이템 행간 최소 거리
        layout.scrollDirection = .horizontal
        
        let collectionViewNews = UICollectionView(frame: .zero, collectionViewLayout: layoutForNews)
        collectionViewNews.delegate = self
        collectionViewNews.dataSource = self
    
        
        
        setUpNews()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width:view.bounds.size.width, height:  view.bounds.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width:  view.bounds.size.width, height: (scrollView.width * 3) + 20)
        
        scrollViewForColl.delegate = self
        myClubView.frame = CGRect(x: 10, y: 40, width: contentCView.width - 20, height: contentCView.width - 20)
        
        // MARK - have to do in showClubController myClubview
        // 해야 할 것 + 버튼 누르면 cell 추가
        // cell 클릭시 데이터 가지고 이동
        // cell customizing 하기
        
        
        //make page with conllection view
        if pageSize == 1 {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.frame = CGRect(x: myClubView.width/10 , y: 10, width: contentCView.width - 80, height: contentCView.width - 80)
            
            collectionView.backgroundColor = .systemGray2
            collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
            collectionView.allowsSelection = true
            collectionView.isPagingEnabled = true

            
            collectionView.isUserInteractionEnabled = true
            collectionView.dataSource = self
            collectionView.delegate = self

           scrollViewForColl.addSubview(collectionView)
            
        }else {
            for i in 0 ..< pageSize {
                
                //for문 안에서 ui conponent를 만들어서 cell 을 상속 받지 못한다..
           
                let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
              
                collectionView.frame = CGRect(x: CGFloat(i) * width , y: 10, width: contentCView.width, height: contentCView.width - 80)
                
                collectionView.backgroundColor = .systemGray2
                collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
                collectionView.allowsSelection = true
                collectionView.isUserInteractionEnabled = true
                collectionView.dataSource = self
                collectionView.delegate = self

               scrollViewForColl.addSubview(collectionView)

            }
        }
        
        
        contentCView.addSubview(myClubView)
        
        myClubView.addSubview(scrollViewForColl)
        myClubView.addSubview(pageControl)
        
        
        contentCView.addSubview(myNews)
        contentCView.addSubview(recClub)
        
        myNews.addSubview(tableView)
        
        scrollView.addSubview(contentCView)
        //view.addSubview(scrollViewForColl)
        view.addSubview(scrollView)
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        scrollViewForColl.frame = CGRect(x: 0, y: 0, width: myClubView.frame.width, height: myClubView.height)
        
        pageControl.frame = CGRect(x: 0, y: myClubView.bottom - 70 , width: myClubView.width, height: 30)
        
      
   
        myClubLabel.frame = CGRect(x: 10, y: 10, width: 20, height: 10)
      


        myNews.frame = CGRect(x: 10, y: myClubView.bottom + 20, width: contentCView.width - 20, height: contentCView.width - 20)
        
        tableView.frame = CGRect(x: 10, y: 10, width: contentCView.width - 40, height: contentCView.width - 40)
        
        recClub.frame = CGRect(x:10, y: myNews.bottom + 20, width: contentCView.width - 20, height: contentCView.width - 20)
    }
    

    
    func setUpNews(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollViewFor: UIScrollView) {
        print("call")
        let cmp = scrollViewFor.frame.maxX
        
           if fmod(scrollViewFor.contentOffset.x, cmp) == 0 {
            print("call if문")
               pageControl.currentPage = Int((scrollViewFor.contentOffset.x) / cmp)
           }
       }


    
}

extension showClubViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //표시할 항목의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if collectionView == collectionViewNews{
//            return data.count
//        }else if collectionView == collectionView {
            return self.numberOfCell
//        }
//        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
        
  
        cell.sizeToFit()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "home"))!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //for header label
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "resuableView", for: indexPath)
//            return headerView
//        default:
//            assert(false, "notiong laoded")
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        // Get the view for the first header
//        let indexPath = IndexPath(row: 0, section: section)
//        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
//
//        // Use this view to calculate the optimal size based on the collection view's width
//        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
//                                                  withHorizontalFittingPriority: .required, // Width is fixed
//                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
//    }
        

        
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
