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
    
    var showView: UIView = {
        let views = UIView()
        let label = UILabel()
        label.text = "아직 승인되지 않은 클럽에 대해 ◯ 가 표시되며 \n승인이 거절된 클럽에 대해 ❎가 표시됩니다. "
        views.addSubview(label)
        label.frame = CGRect(x: 5, y: 5, width:  300, height: 200)
        label.numberOfLines = 5
        label.textColor = UIColor.gray
        return views
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let waitCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        makeLayout(layout: layout)
        waitCollectionView.delegate = self
        waitCollectionView.dataSource = self
        
        waitCollectionView.frame = CGRect(x: 10, y: 100, width: view.width - 10 , height: view.height - 500)
        waitCollectionView.register(clubCollectionViewCell.nib(), forCellWithReuseIdentifier: clubCollectionViewCell.identifier)
        waitCollectionView.backgroundColor = .clear
        view.addSubview(waitCollectionView)
        view.addSubview(showView)
        showView.frame = CGRect(x: 20, y: view.bottom - 200, width: view.width - 40, height: 200)
        
        
        /// Dumm
        waitClubList = Dummy.shared.awaitClub(club: waitClubList)

        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func makeLayout(layout: UICollectionViewFlowLayout){
        layout.scrollDirection = .vertical
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

