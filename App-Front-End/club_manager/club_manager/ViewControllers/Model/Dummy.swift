//
//  Dummy.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/14.
//

import Foundation
class Dummy {
    static let shared = Dummy()
    
    func oneBoard(board: [BoardData]) -> [BoardData] {
        var board: [BoardData] = []
        board.append(BoardData(BoardCategory: "전체글", title: "공지사항", content: "오늘 회의 소회의실입니다 😀", comment: ["확인했습니다", "네 알겠습니다"], count: 10, date: Date()))
        return board
    }
    
    func Boards(board: [BoardData]) -> [BoardData] {
        var board: [BoardData] = []
        
        board.append(BoardData(BoardCategory: "전체글", title: "공지사항", content: "오늘 회의 소회의실입니다 😀", comment: ["확인했습니다", "네 알겠습니다"], count: 10, date: Date()))
        
        board.append(BoardData(BoardCategory: "T/F 회의록", title: "04.10 T/F 회의록", content: "회의 진행 사항에 관한 내용입니다.", comment: ["수고하셨습니다", "정리 최고 최고", "요~"], count: 20, date: Date()))
        
        board.append(BoardData(BoardCategory: "전체글", title: "중간고사 간식 배부 안내사항", content: "중간고사 기간 화이팅입니다", comment: ["우와 감사합니다", "최고 최고"], count: 20, date: Date()))
        
        board.append(BoardData(BoardCategory: "전체글", title: "캠프 관련한 필독 사항!", content: "읽고 확인하시면 확인 댓글 부탁드립니다", comment: ["네!", "확인했습니다", "네~", "네", "확인!"], count: 20, date: Date()))
        
        return board
    }
    
    func oneUser(user: [User]) -> [User] {
        var user: [User] = []
        user.append(User(id: 0, userImage: "person1", userName: "jey", userEmail: "spqjf12345@gmail.com"))
        return user
    }
    
    func Users(user: [User]) -> [User] {
        var user: [User] = []
        user.append(User(id: 1, userImage: "person1", userName: "uri", userEmail: "spqjf12345@gmail.com"))
        user.append(User(id: 2, userImage: "person2", userName: "ddoda", userEmail: "spqjf12345@gmail.com"))
        user.append(User(id: 3, userImage: "person3", userName: "jinhyun", userEmail: "spqjf12345@gmail.com"))
        user.append(User(id: 4, userImage: "person4", userName: "jey", userEmail: "spqjf12345@gmail.com"))
        return user
    }
    
    func awaitClub(club: [Club]) -> [Club] {
        var waitClubList: [Club] = []
        waitClubList.append(Club(id: 0, president: 1, clubImage: "wait1", clubName: "몰입 캠프", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        waitClubList.append(Club(id: 1, president: 1, clubImage: "wait2", clubName: "홍보 모임", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        waitClubList.append(Club(id: 2, president: 1, clubImage: "wait3", clubName: "흰소다", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        waitClubList.append(Club(id: 3, president: 1, clubImage: "wait4", clubName: "week5", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        waitClubList.append(Club(id: 4, president: 1, clubImage: "wait5", clubName: "고독한 캠프", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        waitClubList.append(Club(id: 5, president: 1, clubImage: "wait6", clubName: "강사모", clubSummary: "클럽 요약입니다1", category: "교양", note1: "공지사항입니다 ~~"))
        return waitClubList
    }
    
}
