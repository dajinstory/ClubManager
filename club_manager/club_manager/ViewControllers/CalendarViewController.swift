//
//  CalendarViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/29.
//

import UIKit
import EventKit
import EventKitUI
import FSCalendar
struct setSchedule {
    var title: String
    var date: Date
}
class CalendarViewController: UIViewController, EKEventViewDelegate {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var setScheduledView: UITableView!
    var setscheduled: [setSchedule] = []
    
    var isAddClick = false
    let store = EKEventStore()
    var date = Date()
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        setScheduledView.delegate = self
        setScheduledView.dataSource = self
        calendar.scope = .month
        calendar.scrollDirection = .vertical
        calendar.allowsMultipleSelection = true
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapshare))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        navigationItem.rightBarButtonItems = [add, search, share]
       
    }
    @objc func didTapshare(){
        
    }
    @objc func didTapSearch(){
        
    }
    var dateComponents = DateComponents()
    @objc func didTapAdd(){
        isAddClick = true

        //let vc = EKCalendarChooser()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
    
        
      
    }

}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
        setScheduledView.reloadData()
        print(date)
//        if(isAddClick == true){
//            let vc = EKCalendarChooser()
//
//            vc.showsDoneButton = true
//            vc.showsCancelButton = true
//            present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
//            isAddClick = false
//        }
    
        
    }
    
}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setscheduled.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        return cell
    }
    
    
}
