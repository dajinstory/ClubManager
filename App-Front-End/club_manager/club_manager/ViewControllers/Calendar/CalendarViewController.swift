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


class CalendarViewController: UIViewController, EKEventViewDelegate, UINavigationControllerDelegate {

    private let contentView: UIView = {
        let contentCView = UIView()
        return contentCView
    }()
    
    var calendar = FSCalendar()
    var scrollView: UIScrollView!
    
    private let setScheduledView: UITableView = {
        let setScheduledView = UITableView()
        setScheduledView.register(SetScheduleTableViewCell.nib(), forCellReuseIdentifier: SetScheduleTableViewCell.identifier)
        return setScheduledView
    }()
    
    var setscheduled: [setSchedule] = []
    var filtered: [setSchedule] = []
    var events: [Date] = []
    
    var date = Date()
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        calendar.allowsMultipleSelection = true

        setUp()
        setscheduled = Dummy.shared.schedule(scd: setscheduled)
        filtered = setscheduled
        setUpCalendar()
        print("count : \(setscheduled.count)")
        
//        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapshare))
//        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
       navigationItem.rightBarButtonItems = [add]
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: (scrollView.width * 2) + 150)
     
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 2000)
        calendar.frame = CGRect(x: 0, y: 10, width: view.bounds.width, height: 300)
        setScheduledView.frame = CGRect(x: 0, y: calendar.bottom + 10, width: view.bounds.width, height: view.bounds.height - calendar.height )
        
        contentView.addSubview(calendar)
        contentView.addSubview(setScheduledView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)

    }
    
    func setUp(){
        calendar.delegate = self
        calendar.dataSource = self
        setScheduledView.delegate = self
        setScheduledView.dataSource = self
    }
    
    func setUpCalendar(){
        calendar.scope = .month
        calendar.scrollDirection = .vertical
        calendar.allowsMultipleSelection = false
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        setUpEvents()
        
    }
    
    func setUpEvents() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        //여기에 이벤트 날짜들 적어주면 되겠다.
        //let test = formatter.date(from: "2021-04-03")
        
        events = setscheduled.map{$0.date}
        
    }

    
    var dateComponents = DateComponents()
    @objc func didTapAdd(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
    
        let addVc = AddCalendarViewcontroller()
        self.navigationController?.pushViewController(addVc, animated: true)
    }
    
    func filtersetDayList(day: String){
        filtered = setscheduled.filter { String($0.date.day) == day}
    }

}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
        
        filtersetDayList(day: "\(date.day)")
        setScheduledView.reloadData()
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 1
        } else {
            return 0
        }

        
    }
    
}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SetScheduleTableViewCell.identifier) as! SetScheduleTableViewCell
        cell.configure(with: filtered[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //for delete 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let askToDelete = UIAlertController(title: "일정 삭제", message: "\(filtered[indexPath.row].scTitle) 의 일정을 삭제하시겠습니까?", preferredStyle: .alert)
            
            askToDelete.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.setScheduledView.beginUpdates()
                self.setscheduled.remove(at: indexPath.row)
                self.filtered = self.setscheduled
                self.setScheduledView.deleteRows(at: [indexPath], with: .fade)
                self.setScheduledView.endUpdates()
        }))
            askToDelete.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
            present(askToDelete, animated: true)
        }
    }
    
    
}
