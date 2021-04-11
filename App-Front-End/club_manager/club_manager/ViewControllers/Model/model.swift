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


struct BoardData{
    let userName: String
    let title:String
    let content:String
}

//struct NewsData{
//    var profileImage: String
//    var title: String
//    var content: String
//}
//

// 나의 클럽
struct Club {
    var clubImage: String
    var clubName: String
    var clubSummary: String
    var category: String
    var note1: String
}

// 추천 클럽
struct RecClub {
    var clubImage: String
    var clubName: String
    var clubSummary: String
    var category: String
    var note1: String
}

//승인 대기 클럽
struct waitClub {
    var clubImage: String
    var clubName: String
    var clubSummary: String
    var category: String
    var note1: String
}


