//
//  AddViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/30.
//

import UIKit

//protocol AddCalendarViewcontrollerDelegate
//{
//    func AddCalendarViewcontrollerResponse(_ : parameter)
//}

class AddCalendarViewcontroller: UIViewController, UITextFieldDelegate {
    
    //var delegate: AddCalendarViewcontrollerDelegate?
    
    lazy var hour_textField: UITextField = {
        var title = UITextField()
        title.delegate = self
        title.borderStyle = .roundedRect
        title.layer.borderWidth = 1
        title.layer.borderColor = UIColor.blue.cgColor
        return title
    }()
    
    lazy var minute_textField: UITextField = {
        var title = UITextField()
        title.delegate = self
        title.borderStyle = .roundedRect
        title.layer.borderWidth = 1
        title.layer.borderColor = UIColor.blue.cgColor
        return title
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 50, y: 20, width: self.view.frame.width/2, height: 100))
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
//        datePicker.layer.cornerRadius = 5.0
//        datePicker.layer.shadowOpacity = 0.5
        return datePicker
    }()
    
    private let use_textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.text = "사용 시간"
        textLabel.textColor = .black
        return textLabel
    }()
    
    private let hour_textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.text = "시"
        textLabel.textColor = .black
        return textLabel
    }()
    
    private let minute_textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.text = "분"
        textLabel.textColor = .black
        return textLabel
    }()
    
    private let dateView: UIView = {
        let dateView = UIView()
        dateView.backgroundColor = .white
        return dateView
    }()
    
    lazy var title_textField: UITextField = {
        var title = UITextField()
        title.placeholder = "enter the title"
        title.delegate = self
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.blue.cgColor
        title.borderStyle = .roundedRect
        return title
    }()
    
    lazy var add_Button: UIButton = {
        var add_Button = UIButton()
        add_Button.setTitle("일정 추가", for: .normal)
        add_Button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        add_Button.setTitleColor(UIColor.white, for: .normal)
        add_Button.layer.borderWidth = 2
        add_Button.layer.borderColor = UIColor.blue.cgColor
        add_Button.layer.backgroundColor = UIColor.blue.cgColor
        return add_Button
    }()
    
    @objc func didTapAddButton(){
        let calendarVC = CalendarViewController()
        calendarVC.setscheduled.append(setSchedule(date: datePicker.date, scTitle: title_textField.text!, scHour: hour_textField.text!, scMinute: minute_textField.text!))
        self.navigationController?.popToViewController(calendarVC, animated: true)
        
//        print(datePicker.date)
//        print(title_textField.text!)
//        print(hour_textField.text!)
//        print(minute_textField.text!)
//        print(datePicker.date.year)
//        print(datePicker.date.month)
//        print(datePicker.date.day)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        layout()
        title = "일정 추가"

        view.backgroundColor = .white
        view.addSubview(datePicker)
        view.addSubview(dateView)
        
        dateView.addSubview(use_textLabel)
        dateView.addSubview(hour_textField)
        dateView.addSubview(hour_textLabel)
        dateView.addSubview(minute_textField)
        dateView.addSubview(minute_textLabel)

        view.addSubview(title_textField)
        view.addSubview(add_Button)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        datePicker.backgroundColor = .red
        datePicker.frame = CGRect(x: 50, y: 200, width: view.bounds.width - 100, height: 100)
        
        dateView.frame = CGRect(x: 50, y: datePicker.bottom + 50, width: view.bounds.width - 40, height: 25)
        use_textLabel.frame = CGRect(x: 50, y: 0, width: 100, height: 25)
        hour_textField.frame = CGRect(x: use_textLabel.frame.maxX , y: 0, width: 30, height: 25)
        hour_textLabel.frame = CGRect(x: hour_textField.frame.maxX, y: 0, width: 50, height: 25)
        minute_textField.frame = CGRect(x: hour_textLabel.frame.maxX, y: 0, width: 30, height: 25)
        minute_textLabel.frame = CGRect(x: minute_textField.frame.maxX, y: 0, width: 100, height: 25)
        title_textField.frame = CGRect(x: 0, y: dateView.bottom + 70, width: view.bounds.width, height: 50)
        add_Button.frame = CGRect(x: view.frame.width/2 - 50, y: title_textField.bottom + 70, width: 100, height: 50)
        
    }
    
    func layout(){
        //NSLayoutConstraint.init(item: )
    }
    
    
    
  
    


}
