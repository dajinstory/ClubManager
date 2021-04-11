//
//  SearchClubViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit

class SearchClubViewController: UIViewController, UITextFieldDelegate {

    var AllClubList: [Club] = []
    var FilteredClubList: [Club] = []
    var waitClubList: [WaitClub] = []
    
    var club_name = ""
    var categry = ""
    var club_image = ""
    var club_ummary = ""
    var note = ""
    
    
    private let AllClubTableView : UITableView = {
        let table = UITableView()
        table.register(SearchClubTableViewCell.nib(), forCellReuseIdentifier:SearchClubTableViewCell.identifier)
        return table
    }()
    
    lazy var searchView : UITextField = {
        let view = UITextField()
        view.placeholder = "enter the club name"
        view.delegate = self
        view.clearButtonMode = .always
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.blue.cgColor
        view.borderStyle = .roundedRect
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "클럽 찾기"
        addAllClubList()
        AllClubTableView.delegate = self
        AllClubTableView.dataSource = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 50)
        AllClubTableView.frame = CGRect(x: 0, y: searchView.bottom + 20, width: view.bounds.width, height: view.bounds.height - 50)
        view.addSubview(searchView)
        view.addSubview(AllClubTableView)
    }
    
    
    ///dummy
    func addAllClubList(){
        AllClubList.append(Club(clubImage: "image1", clubName: "다꾸 모임", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        AllClubList.append(Club(clubImage: "image2", clubName: "떡사모", clubSummary: "클럽 요약입니다2", category: "팬", note1: "공지사항입니다 ~~"))
        AllClubList.append(Club(clubImage: "image3", clubName: "우비 사랑", clubSummary: "클럽 요약입니다3", category: "스포츠", note1: "공지사항입니다 ~~"))
        AllClubList.append(Club(clubImage: "image4", clubName: "아아 사랑", clubSummary: "클럽 요약입니다4", category: "영화", note1: "공지사항입니다 ~~"))
        AllClubList.append(Club(clubImage: "image5", clubName: "샤이니월드", clubSummary: "클럽 요약입니다5", category: "교양", note1: "공지사항입니다 ~~"))
        AllClubList.append(Club(clubImage: "image6", clubName: "박보검 공식 팬카페", clubSummary: "클럽 요약입니다6", category: "교양", note1: "공지사항입니다 ~~"))
        AllClubList.append(Club(clubImage: "image7", clubName: "가구 정보 공유 모임", clubSummary: "클럽 요약입니다7", category: "교양", note1: "공지사항입니다 ~~"))
        
        for str in AllClubList {
            FilteredClubList.append(str)
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool { // x 버튼으로 다 지웠을 때
        searchView.resignFirstResponder()
        searchView.text = ""
        self.FilteredClubList.removeAll()
        for str in AllClubList {
            FilteredClubList.append(str)
        }
        AllClubTableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //enter 눌렀을 때
        if searchView.text?.count != 0 {
            self.FilteredClubList.removeAll()
            for str in AllClubList {
                let name = str.clubName.lowercased()
                let range = name.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.FilteredClubList.append(str)
                }
                
            }
        }
        AllClubTableView.reloadData()
        return true
    }
    
    //textfield가 글자 입력 중일때
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText  = textField.text! + string
        if searchText.count >= 3{
            FilteredClubList = AllClubList.filter({ (result) -> Bool in
                result.clubName.range(of: searchText, options: .caseInsensitive) != nil
            })
        }else {
            FilteredClubList = AllClubList
        }
       
        AllClubTableView.reloadData()
        return true
    }
    
}

extension SearchClubViewController: UITableViewDelegate, UITableViewDataSource, SearchClubTableViewCellDelegate {
    func onTouchWaitButton(from cell: SearchClubTableViewCell) {
          let alert = UIAlertController(title: "승인 요청", message: "가입 승인을 요청하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
          let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                      print("okAction clicked")
                      // 클럽 이름, .. 정보 가져와서 대기 클럽에 추가
                      // 클럽장이 승인 요청 클럽 승인하면 사용자의 클럽에 클럽 추가
            
//            print(cell.imageName!)
            //print(String(cell.clubImage))
                      //clubName으로 조회 and id로 조회 후
        
            
            guard let club_Name = cell.clubName.text else {return}
            guard let image_Name = cell.imageName else {return}
            print(club_Name)
            print(image_Name)
            self.waitClubList.append(WaitClub(clubImage: image_Name, clubName: club_Name, clubSummary: "hey", category: "영화", note1: "공지사항 입니다"))
            self.showToast(message: "\(club_Name) 클럽에 승인 요청을 하였습니다.", font: .boldSystemFont(ofSize: 10))
                  }
          let cancelAction = UIAlertAction(title: "CANCEL", style: .default) {(action) in

              //nothing to do
              print("cancelAction clicked")

          }
          alert.addAction(okAction)
          alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilteredClubList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SearchClubTableViewCell.identifier) as! SearchClubTableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell") as! SearchClubTableViewCell
        }
        cell.configure(with: FilteredClubList[indexPath.row])
        cell.delegate = self
//        cell.btn.
        
//        let button = UIButton()
//        button.setTitle("승인 요청", for: .normal)
//        button.setTitleColor(UIColor.white, for: .highlighted)
//        button.backgroundColor = .systemBlue
//        button.frame = CGRect(x: 250, y: 40, width: 100, height: 50)
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        cell.addSubview(button)

        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var cell = tableView.dequeueReusableCell(withIdentifier: SearchClubTableViewCell.identifier) as! SearchClubTableViewCell
//        
//        club_name = self.AllClubList[indexPath.row].clubName
//        categry = self.AllClubList[indexPath.row].category
//        club_image = self.AllClubList[indexPath.row].clubImage
//        club_ummary = self.AllClubList[indexPath.row].clubSummary
//        note = self.AllClubList[indexPath.row].note1
//        
//    }
    
    @objc func didTapButton(){
        print("did tap button")
        let alert = UIAlertController(title: "승인 요청", message: "가입 승인을 요청하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print("okAction clicked")
                    // 클럽 이름, .. 정보 가져와서 대기 클럽에 추가
                    // 클럽장이 승인 요청 클럽 승인하면 사용자의 클럽에 클럽 추가

            
                }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default) {(action) in
            
            //nothing to do
            print("cancelAction clicked")
            
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: false, completion: nil)
    }
    
    
}
