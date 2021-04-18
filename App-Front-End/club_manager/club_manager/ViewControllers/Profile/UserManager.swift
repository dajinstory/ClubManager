//
//  UserManager.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/15.
//

import SwiftUI

struct UserManager: View {
    //get all user data
    var datas: [User]
    
    var body: some View {
        Spacer()
        VStack(alignment: .leading, spacing: 20, content: {
            Text("회원 정보 관리")
                .bold()
                .font(.title)
        })
        Spacer()
        List(datas) { item in
            ItemView(data: item)
        }

    }
}

struct ItemView: View {
    var data: User
        var body: some View {
            
            HStack(alignment: .top, spacing: 10, content: {
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.gray))
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                    Spacer()
                    VStack(spacing: 5) {
                        Text(data.userName)
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    
                        Text(data.userEmail)
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    Spacer()
                    Image(systemName: "info")
                        .frame(width: 25, height: 25)
                        .background(Circle().fill(Color.gray))
                        .padding(.leading, 10)
                }
                .padding()
                .background(Rectangle().fill(Color.white))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
            })
            
        }
    }
        

//dummy data
extension UserManager {
    static var getAllUser = [
        User(id: 1, userImage: "person.fill", userName: "한다진", userEmail: "sldgk@gmail.com"),
        User(id: 2, userImage: "person.fill", userName: "공희재", userEmail: "sldgk@gmail.com"),
        User(id: 3, userImage: "person.fill", userName: "김민주", userEmail: "sldgk@gmail.com"),
        User(id: 4, userImage: "person.fill", userName: "이정인", userEmail: "sldgk@gmail.com")
    ]
}

struct UserManager_Previews: PreviewProvider {
    static var previews: some View {
        return UserManager(datas: UserManager.getAllUser)
    }
}

