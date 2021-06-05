//
//  DetailBoardViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import UIKit

class DetailBoardViewController: UIViewController {
    
    var noteData: Post = Post(BoardCategory: 0, id: 0, title: "", content: "", comments: "", date: "", views: 0, userId: 0)
    var userData: User = User(id: 0, email: "", name: "", clubs: "")
    
    var FrameTableView: UITableView = {
        var table = UITableView()
        table.register(DetailSection1TableViewCell.nib(), forCellReuseIdentifier: DetailSection1TableViewCell.identifier)
//        table.register(DetailSection2TableViewCell.nib(), forCellReuseIdentifier: DetailSection2TableViewCell.identifier)
        table.register(DetailSection3TableViewCell.nib(), forCellReuseIdentifier: DetailSection3TableViewCell.identifier)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
//    var commentTableView: UITableView = {
//        var table = UITableView()
//        table.register(DetailSection3TableViewCell.nib(), forCellReuseIdentifier: DetailSection3TableViewCell.identifier)
//        return table
//    }()
    
    var contentTextview: UITextView = {
        var textview = UITextView()
        textview.isUserInteractionEnabled = true
        textview.isSelectable = true
        textview.isEditable = false
        return textview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(FrameTableView)
        FrameTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 200)
        FrameTableView.dataSource = self
        FrameTableView.delegate = self

        initRefresh()
        
        contentTextview.text = noteData.content
        contentTextview.font = .systemFont(ofSize: 30)
        contentTextview.frame = CGRect(x: 10, y: 10, width: view.width - 30, height: view.height - 300)
        makeContentView()
        
    

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func initRefresh(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullRefresh(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "refresh ..")
        FrameTableView.addSubview(refresh)
        
    }
    
    @objc func didPullRefresh(refresh: UIRefreshControl){
        refresh.endRefreshing() // refresh end
        FrameTableView.reloadData()
    }
    
    @objc func didTapShareToolBar(){
        guard let image = UIImage(systemName: "bell.fill"), let url = URL(string: "https://google.com") else { return }
        let shareSheetVc = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVc, animated: true, completion: nil)
    }
    
    func makeContentView(){
        let image1Attachment = NSTextAttachment()
        let localImage = UIImage(named: "rabbit")!
        image1Attachment.image = localImage
        
        let newImageWidth = (contentTextview.bounds.size.width - 30)
        let scale = newImageWidth/localImage.size.width
        let newImageHeight = (localImage.size.height - 30) * scale
        image1Attachment.bounds = CGRect.init(x: 0, y: 300, width: newImageWidth, height: newImageHeight)
       
        image1Attachment.image = UIImage(cgImage: (image1Attachment.image?.cgImage!)!, scale: scale, orientation: .up)
        
        let imgString = NSAttributedString(attachment: image1Attachment)
        let combination = NSMutableAttributedString()
        let fontSize = UIFont.boldSystemFont(ofSize: 20)

        let NSMAString = NSMutableAttributedString(string: contentTextview.text)
        NSMAString.addAttribute(.font, value: fontSize, range: (contentTextview.text as NSString).range(of: contentTextview.text))
            
        combination.append(NSMAString)
        combination.append(imgString)
        contentTextview.attributedText = combination
    }
    

}

extension DetailBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: DetailSection1TableViewCell.identifier) as! DetailSection1TableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let cell3 = tableView.dequeueReusableCell(withIdentifier: DetailSection3TableViewCell.identifier) as! DetailSection3TableViewCell
        if(indexPath.row == 0){
            cell1.configure(modelBoard: noteData, modelUser: userData)
            return cell1
        }else if(indexPath.row == 1){
            cell2.addSubview(contentTextview)
            return cell2
        }else if(indexPath.row == 2){
            let cell3Height:CGFloat = 500
            cell3.size(width: cell3.bounds.width, height : cell3Height)
            return cell3
        }
       
        return cell1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){//title
            return 100
        }else if(indexPath.row == 1){ //content
            return view.height - 200
        }else { //comment
            return 700
        }
//        tableView.rowHeight = UITableView.automaticDimension

    }
  
    
    
}
