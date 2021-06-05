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

// 나의 클럽
struct Club: Codable {
    var id: Int64
    var president: Int64
    var clubName: String
    var clubSummary: String
    var category: String
//    var note1: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case president
        case clubName = "name"
        case clubSummary
        case category
    }
    
}

struct User: Codable {
    var id: Int64
    //let image: String
    let email: String
    let name: String
    let clubs: String
    
}


struct Post: Codable {
    var BoardCategory: Int64
    var id: Int64
    var title:String
    var content:String
    var comments: String
    var date :String
    var views: Int64
    var userId: Int64
    
    enum CodingKeys: String, CodingKey {
        
        case BoardCategory = "boardId"
        case id
        case title
        case content
        case comments
        case date
        case views
        case userId = "writer"
    }
}

struct Board: Codable {
    let clubId: Int64
    let id: Int64
    let name: String
    let auth: Int64
}

//공지 보드
struct StarNote {
    let starNote: Post
}


struct setSchedule {
    var date: Date
    var scTitle: String
    var scHour: String
    var scMinute: String
}

class currentStatus {
    static var userId: Int64 = -1
    static var clubId: Int64 = -1
    static var boardId: Int64 = 1 //default board is 1
    static var postId: Int64 = -1
    
}




