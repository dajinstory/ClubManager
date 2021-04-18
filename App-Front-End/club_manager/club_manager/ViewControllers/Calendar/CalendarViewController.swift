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
    
    var calendar = FSCalendar()
    
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
        calendar.allowsMultipleSelection = true

        setUp()
        setupData()
        setUpCalendar()
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapshare))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
       navigationItem.rightBarButtonItems = [add, search, share]
        
        view.addSubview(calendar)
        view.addSubview(setScheduledView)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        setScheduledView.frame = CGRect(x: 0, y: calendar.bottom + 10, width: view.bounds.width, height: view.bounds.height - calendar.height - 100)
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
        
      
        //print("event")
        events = setscheduled.map{$0.date}
        //print(events)
        
    }

    
    
    func setupData(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-11")! , scTitle: "일정1", scHour: "2", scMinute: "20"))
        
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-12")!, scTitle: "일정2", scHour: "3", scMinute: "20"))
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-13")!, scTitle: "일정3", scHour: "2", scMinute: "40"))
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-14")!, scTitle: "일정4", scHour: "2", scMinute: "10"))
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-14")!, scTitle: "일정5", scHour: "2", scMinute: "00"))
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-15")!, scTitle: "일정6", scHour: "2", scMinute: "30"))
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-04-16")!, scTitle: "일정7", scHour: "2", scMinute: "20"))
        setscheduled.append(setSchedule(date: formatter.date(from: "2021-05-11")!, scTitle: "일정8", scHour: "2", scMinute: "20"))
        
//        setscheduled.append(setSchedule(title: "일정2", year: "2021", month: "5", day: "1", date: formatter.date(from: "2021-5-1")!))
//        setscheduled.append(setSchedule(title: "일정3", year: "2021", month: "6", day: "2", date: formatter.date(from: "2021-6-2")!))
//        setscheduled.append(setSchedule(title: "일정4", year: "2021", month: "4", day: "27", date: formatter.date(from: "2021-4-27")!))
//        setscheduled.append(setSchedule(title: "일정5", year: "2021", month: "4", day: "28", date: formatter.date(from: "2021-4-28")!))
//        setscheduled.append(setSchedule(title: "일정6", year: "2021", month: "5", day: "1", date: formatter.date(from: "2021-5-1")!))
//        setscheduled.append(setSchedule(title: "일정7", year: "2021", month: "6", day: "28", date: formatter.date(from: "2021-6-28")!))
//        setscheduled.append(setSchedule(title: "일정8", year: "2021", month: "4", day: "27",date: formatter.date(from: "2021-4-27")!) )
//        setscheduled.append(setSchedule(title: "일정9", year: "2021", month: "4", day: "29", date: formatter.date(from: "2021-4-29")!))
//        setscheduled.append(setSchedule(title: "일정10", year: "2021", month: "5", day: "30", date: formatter.date(from: "2021-5-30")!))
//        setscheduled.append(setSchedule(title: "일정11", year: "2021", month: "6", day: "2", date: formatter.date(from: "2021-6-2")!))
//        setscheduled.append(setSchedule(title: "일정12", year: "2021", month: "4", day: "4", date: formatter.date(from: "2021-4-4")!))
        filtered = setscheduled
    }
    
    @objc func didTapshare(){
        
    }
    @objc func didTapSearch(){
        
    }
    
    var dateComponents = DateComponents()
    @objc func didTapAdd(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
//        let addVc = self.storyboard?.instantiateViewController(identifier: "Add")
//        print("addvc : \(addVc?.restorationIdentifier as Any)")
        //let addVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Add")
        
        let addVc = AddCalendarViewcontroller()
        self.navigationController?.pushViewController(addVc, animated: true)
    }
    
    func filtersetDayList(day: String){
        filtered = setscheduled.filter { String($0.date.day) == day}
//        print("filter")
//        print(filtered)
    }

}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date

        //print(date.day)
        
        filtersetDayList(day: "\(date.day)")
        setScheduledView.reloadData()
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        print("date")
//        print(date)
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
    
    
}
