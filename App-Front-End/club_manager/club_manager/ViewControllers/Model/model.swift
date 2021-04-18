//
//  model.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/05.
//

import Foundation

struct Constants {

struct Storyboard {

    static let homeViewController = "HomeVC"

    static let tabBarController = "HomeTVC"

    static let mainStoryBoard = "Main"
}
}

struct User: Identifiable {
    var id: Int
    let userImage: String 
    let userName: String
    let userEmail: String
}


struct BoardData{
    let BoardCategory: [String]
    let title:String
    let content:String
    let comment: [String]
    let count: Int
    let date :Date
}

//공지 보드
struct StarNote {
    let starNote: BoardData
}

//struct NewsData{
//    var profileImage: String
//    var title: String
//    var content: String
//}
//

// 나의 클럽
struct Club {
    var id: Int64
    var president: Int64
    var clubImage: String
    var clubName: String
    var clubSummary: String
    var category: String
    var note1: String
}

// 추천 클럽
//struct RecClub {
//    var clubImage: String
//    var clubName: String
//    var clubSummary: String
//    var category: String
//    var note1: String
//}

//승인 대기 클럽
//struct WaitClub {
//    var clubImage: String
//    var clubName: String
//    var clubSummary: String
//    var category: String
//    var note1: String
//}

struct setSchedule {
    var date: Date
    var scTitle: String
    var scHour: String
    var scMinute: String
}




