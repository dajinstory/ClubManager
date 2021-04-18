//
//  DetailSection3TableViewCell.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/13.
//

import UIKit

//comment tableview
class DetailSection3TableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "DetailSection3TableViewCell"
    var sectionComment = ["123", "234", "345"]
    var reComment1 = ["1-1", "1-2"]
    public var cellHeight:CGFloat = 50
    private let commnetTavleView: UITableView = {
        var table = UITableView()
        table.backgroundColor = .systemRed
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter the comment"
        return textField
    }()
    
    private var EnterButton : UIButton = {
        var button = UIButton()
        button.setTitle("enter", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapEnterButton(){
        print("didTapEnterButton")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commnetTavleView.delegate = self
        commnetTavleView.dataSource = self
        commentTextField.delegate = self
        addSubview(commnetTavleView)
        addSubview(commentTextField)
        addSubview(EnterButton)
        
    }

    
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailSection3TableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func size(width: CGFloat, height: CGFloat){
        print("frame called")
        print("height is \(height)")
        commnetTavleView.frame = CGRect(x: 0, y: 0, width: width + 100, height: height - 100)
        commentTextField.frame = CGRect(x: 0, y: commnetTavleView.bottom + 5, width: width - 100, height: 100)
        EnterButton.frame = CGRect(x: commentTextField.bounds.maxX, y: commnetTavleView.bottom + 5, width: 100, height: 100)
    }
    
//    func configure(with model: sectionComment){
//        self.sectionComment = model
//        commnetTavleView.reloadData()
//    }
    
}

extension DetailSection3TableViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionComment.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionComment[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = sectionComment[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
