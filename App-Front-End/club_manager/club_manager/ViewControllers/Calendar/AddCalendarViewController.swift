//
//  AddViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/30.
//

import UIKit
import DatePickerDialog



class AddCalendarViewcontroller: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    lazy var hour_textField: UITextField = {
        var title = UITextField()
        title.delegate = self
        title.borderStyle = .roundedRect
        title.layer.borderWidth = 1
        title.layer.borderColor = UIColor.black.cgColor
        return title
    }()
    
    lazy var minute_textField: UITextField = {
        var title = UITextField()
        title.delegate = self
        title.borderStyle = .roundedRect
        title.layer.borderWidth = 1
        title.layer.borderColor = UIColor.black.cgColor
        return title
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 50, y: 20, width: 300, height: 100))
        datePicker.backgroundColor = .yellow
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
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
        title.layer.borderColor = UIColor.black.cgColor
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
        
//        let dataFormatter = DateFormatter()
//        dataFormatter.dateFormat = "YYYY-MM-dd"
        guard ((self.title_textField.text?.isEmpty) != nil), ((self.hour_textField.text?.isEmpty) != nil),((self.minute_textField.text) != nil) else {
            return
        }
        let alert = UIAlertController(title: "일정 추가", message: " \(datePicker.date.month)월 \(datePicker.date.day)일 \(title_textField.text!) 일정을 추가하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (okButton) in
                let calendarVC = CalendarViewController()
            calendarVC.setscheduled.append(setSchedule(date: self.datePicker.date, scTitle: self.title_textField.text!, scHour: self.hour_textField.text!, scMinute: self.minute_textField.text!))
            self.navigationController?.pushViewController(calendarVC, animated: true)
            
            })
        )
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        present(alert, animated: true)
        
        
//        calendarVC.setscheduled.append(setSchedule(date: datePicker.date, scTitle: title_textField.text!, scHour: hour_textField.text!, scMinute: minute_textField.text!))
//        self.navigationController?.popToViewController(calendarVC, animated: true)
        
    }
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "일정 추가"
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)

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
        datePicker.frame = CGRect(x: 50, y: 200, width: view.bounds.width, height: 100)
        
        dateView.frame = CGRect(x: 50, y: datePicker.bottom + 50, width: view.bounds.width - 40, height: 25)
        use_textLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
        use_textLabel.font = .boldSystemFont(ofSize: 20)
        
        hour_textField.frame = CGRect(x: use_textLabel.frame.maxX , y: 0, width: 50, height: 25)
        hour_textLabel.frame = CGRect(x: hour_textField.frame.maxX + 5, y: 0, width: 50, height: 25)
        hour_textLabel.font = .boldSystemFont(ofSize: 20)
        
        minute_textField.frame = CGRect(x: hour_textLabel.frame.maxX, y: 0, width: 50, height: 25)
        minute_textLabel.frame = CGRect(x: minute_textField.frame.maxX + 5, y: 0, width: 100, height: 25)
        minute_textLabel.font = .boldSystemFont(ofSize: 20)
        
        title_textField.frame = CGRect(x: 0, y: dateView.bottom + 70, width: view.bounds.width, height: 50)
        
        add_Button.frame = CGRect(x: view.frame.width/2 - 50, y: title_textField.bottom + 70, width: 100, height: 50)
        
    }
}
