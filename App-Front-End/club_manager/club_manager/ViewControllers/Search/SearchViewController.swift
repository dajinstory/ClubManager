//
//  searchViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/25.
//
import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    var allBoardData: [BoardData] = []
    var FilteredBoardData: [BoardData] = []
    
    lazy var searchView : UITextField = {
        let view = UITextField()
        view.placeholder = "검색어 입력"
        view.delegate = self
        view.clearButtonMode = .always
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.borderStyle = .roundedRect
        return view
    }()
    
    private var AllNoteTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       return table
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.white
        AllNoteTableView.delegate = self
        AllNoteTableView.dataSource = self
        
        setUpallBoardData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        AllNoteTableView.frame = view.bounds
        view.addSubview(searchView)
        view.addSubview(AllNoteTableView)
        
        searchView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 60)
        AllNoteTableView.frame = CGRect(x: 0, y: searchView.bottom + 10, width: view.bounds.width, height: view.bounds.height - 50)
       }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool { // x 버튼으로 다 지웠을 때
        searchView.resignFirstResponder()
        searchView.text = ""
        self.FilteredBoardData.removeAll()
        for str in allBoardData {
            FilteredBoardData.append(str)
        }
        AllNoteTableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //enter 눌렀을 때
        if searchView.text?.count != 0 {
            self.FilteredBoardData.removeAll()
            for str in allBoardData {
                let name = str.title.lowercased()
                let range = name.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.FilteredBoardData.append(str)
                }
                
            }
        }
        AllNoteTableView.reloadData()
        return true
    }
    
    //textfield가 글자 입력 중일때
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText  = textField.text! + string
        if searchText.count >= 3{
            FilteredBoardData = allBoardData.filter({ (result) -> Bool in
                result.title.range(of: searchText, options: .caseInsensitive) != nil
            })
        }else {
            FilteredBoardData = allBoardData
        }
       
        AllNoteTableView.reloadData()
        return true
    }
    
    ///dummy
    func setUpallBoardData(){
        let dateFormatter = DateFormatter()
        let dateToDate = dateFormatter.date(from: "2021.04.11 21:09")
        allBoardData.append(BoardData(BoardCategory: "전체글", title: "11월 회의 안건", content: "11월 회의 안건은 ~~ 한 내용입니다", comment: ["00", "11"], count: 1, date: dateToDate ?? Date()))
        allBoardData.append(BoardData(BoardCategory: "회의록", title: "12월 회의 안건", content: "12월 회의 안건은 ~~ 한 내용입니다", comment: ["00", "11"], count: 1, date: dateToDate ?? Date()))
        allBoardData.append(BoardData(BoardCategory: "장부", title: "1월 회의 안건", content: "1월 회의 안건은 ~~ 한 내용입니다", comment: ["00", "11"], count: 1, date: dateToDate ?? Date()))
        allBoardData.append(BoardData(BoardCategory: "전체글", title: "2월 회의 안건", content: "2월 회의 안건은 ~~ 한 내용입니다", comment: ["00", "11"], count: 1, date: dateToDate ?? Date()))
        allBoardData.append(BoardData(BoardCategory: "전체글", title: "3월 회의 안건", content: "3월 회의 안건은 ~~ 한 내용입니다", comment: ["00", "11"], count: 1, date: dateToDate ?? Date()))
        allBoardData.append(BoardData(BoardCategory: "전체글", title: "4월 회의 안건", content: "4월 회의 안건은 ~~ 한 내용입니다", comment: ["00", "11"], count: 1, date: dateToDate ?? Date()))
        FilteredBoardData = allBoardData
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FilteredBoardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = FilteredBoardData[indexPath.row].title
        cell.detailTextLabel?.text = FilteredBoardData[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == AllNoteTableView {
            return 100
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //note click 시 detail notet로 이동
        let detailVc = DetailBoardViewController()
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
}

