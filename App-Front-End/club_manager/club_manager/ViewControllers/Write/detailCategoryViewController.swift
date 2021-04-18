//
//  detailCategoryViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/14.
//

import UIKit

class detailCategoryViewController: UIViewController {
    var category = ["전체글", "공지사항", "즐겨찾기"]
    var selectedCategory = ""
    private let FrameTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FrameTableView.dataSource = self
        FrameTableView.delegate = self
        view.addSubview(FrameTableView)
        FrameTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
    }
    

 

}

extension detailCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = category[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = category[indexPath.row]
        self.popToViewcontroller(category: selectedCategory)
        
    }
    
    func popToViewcontroller(category: String){
        let writeVc = WriteViewController()
        writeVc.categoryButton.setTitle(category, for: .normal)
        writeVc.category = category
        
        writeVc.titleTextField.text = UserDefaults.standard.string(forKey: "titleText")
        writeVc.contentTextView.text = UserDefaults.standard.string(forKey: "contentText")
        
        self.navigationController?.pushViewController(writeVc, animated: true)
    }
    
    
}
