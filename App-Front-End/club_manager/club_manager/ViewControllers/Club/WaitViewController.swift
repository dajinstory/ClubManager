//
//  WaitViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/11.
//

import UIKit

class WaitViewController: UIViewController {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var waitClubList: [Club] = []
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let waitCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        makeLayout(layout: layout)
        waitCollectionView.delegate = self
        waitCollectionView.dataSource = self
        
        waitCollectionView.frame = CGRect(x: 10, y: 50, width: view.width - 10 , height: view.height - 100)
        waitCollectionView.register(clubCollectionViewCell.nib(), forCellWithReuseIdentifier: clubCollectionViewCell.identifier)
        waitCollectionView.backgroundColor = .clear
        view.addSubview(waitCollectionView)
        addWaitClubList()

        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func makeLayout(layout: UICollectionViewFlowLayout){
        layout.scrollDirection = .vertical
    }
    
    ///dummy
    func addWaitClubList(){
//        waitClubList.append(Club(clubImage: "image1", clubName: "몰입 캠프", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
//        waitClubList.append(Club(clubImage: "image2", clubName: "힐링 모임", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
//        waitClubList.append(Club(clubImage: "image3", clubName: "흰소다", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
//        waitClubList.append(Club(clubImage: "image4", clubName: "week5", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
//        waitClubList.append(Club(clubImage: "image5", clubName: "고독한 캠프", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
//        waitClubList.append(Club(clubImage: "image6", clubName: "강사모", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
//        waitClubList.append(Club(clubImage: "image7", clubName: "등산 모임", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
    }
    
    


}
extension WaitViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        waitClubList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: clubCollectionViewCell.identifier, for: indexPath) as! clubCollectionViewCell
        cell.configureForWait(with: waitClubList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mElementSize = CGSize(width: 100, height: 150)
            return mElementSize;
    }
   
    
}

