//
//  UserManager.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/15.
//

//import SwiftUI
//
//struct UserManager: View {
//    //get all user data
//    var datas: [User]
//    
//    var body: some View {
//        Spacer()
//        VStack(alignment: .leading, spacing: 20, content: {
//            Text("회원 정보 관리")
//                .bold()
//                .font(.title)
//        })
//        Spacer()
//        List {
//            //Section(footer: ListFooter()){
//                ForEach(datas) {
//                    item in ItemView(data: item)
//                }
//            //}
//        }
//
//    }
//    
//
//    
//}
//
//struct ListFooter: View {
//    @State private var showAddModal = false
//    var body: some View {
//        
//        HStack{
//            Spacer()
//            Button(action: {
//               print("button click")
//                self.showAddModal = true
//                //add TAble cel;
//            }, label: {
//                Text("+").font(.title)
//            }).frame(width: 100, height: 100)
//            .background(Color.yellow)
//            .sheet(isPresented: self.$showAddModal, content: {
//                ModalView() // 아래 모달 뷰 보여줌
//            })
//            Spacer()
//        }
//        
//    }
//}
//struct ModalView: View {
//    //environment 변수
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//    var body: some View {
//        Group {
//          Text("Modal view")
//          Button(action: {
//             self.presentationMode.wrappedValue.dismiss()
//          }) {
//            Text("Dismiss")
//          }
//        }
//      }
//}
//
//struct ItemView: View {
//    var data: User
//        var body: some View {
//            
//            HStack(alignment: .top, spacing: 10, content: {
//                HStack {
//                    Image(uiImage:
//                            UIImage(imageLiteralResourceName: data.userImage))
//                        .frame(width: 50, height: 50)
//                        .background(Circle().fill(Color.gray))
//                        .clipShape(Circle())
//                        .padding(.trailing, 10)
//                    Spacer()
//                    VStack(spacing: 5) {
//                        Text(data.userName)
//                            .font(.callout)
//                            .lineLimit(1)
//                        Spacer()
//                    
//                        Text(data.userEmail)
//                            .font(.callout)
//                            .lineLimit(1)
//                        Spacer()
//                    }
//                    Spacer()
//                    
//                    Image(systemName: "info")
//                        .frame(width: 25, height: 25)
//                        .background(Circle().fill(Color.gray))
//                        .padding(.leading, 10)
//                }
//                .padding()
//                .background(Rectangle().fill(Color.white))
//                .cornerRadius(10)
//                .shadow(color: .gray, radius: 3, x: 2, y: 2)
//            })
//            
//        }
//    }
//        
//
////dummy data
//extension UserManager {
//  
//    static var getAllUser = [
////        User(id: 1, userImage: "person1", userName: "한다진", userEmail: "daginstrou@gmail.com"),
////        User(id: 2, userImage: "person2", userName: "공희재", userEmail: "heejay@gmail.com"),
////        User(id: 3, userImage: "person3", userName: "김민주", userEmail: "migu@gmail.com"),
////        User(id: 4, userImage: "person4", userName: "이정인", userEmail: "jinrheee@gmail.com")
//    ]
//}
//
//struct UserManager_Previews: PreviewProvider {
//    static var previews: some View {
//        return UserManager(datas: UserManager.getAllUser)
//    }
//}
//
