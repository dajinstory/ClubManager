//
//  File.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/05/24.
//

import Foundation

class DataManger {
    
    func getMyBoards(clubId: Int64, completionHandler: @escaping (_ result: [Board]) -> ()) {
        let url_URL = URL(string: "\(APIAddress.address)/board")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
        request.setValue(String(clubId), forHTTPHeaderField: "clubId")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                ///array deData
                let deData = try decoder.decode([Board].self, from: data)
                
                completionHandler(deData) // Board struct 를 return
                
            }catch let err {
                print("ERROR", err)
            }
            
        }.resume()
    }
    
    func getPostBoardId(clubId: Int64, boardId: Int64, completionHandler: @escaping (_ result: [Post]) -> ()){
        let url_URL = URL(string: "\(APIAddress.address)/post")
        var request = URLRequest(url: url_URL!)

        request.httpMethod = "GET"
        request.setValue("-1", forHTTPHeaderField: "clubId")
        request.setValue(String(boardId), forHTTPHeaderField: "boardId")
        ///data task - Creates a task that retrieves the contents of a URL based on the specified URL request object.
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                ///array deData
                let deData = try decoder.decode([Post].self, from: data)
                
                completionHandler(deData) // Post struct 를 return
                
            }catch let err {
                print("ERROR", err)
            }
            
        }.resume()
        
    }
    
    
//    func getMyClubs(clubs: String, completionHandler: @escaping (_ result: Club) -> ()) {
//        // check user if already registered
//        let url_URL = URL(string: "\(APIAddress.address)/club")
//        var request = URLRequest(url: url_URL!)
//
//        request.httpMethod = "GET"
//        request.setValue(clubs, forHTTPHeaderField: "clubs")
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
//
//            do {
//                let decoder = JSONDecoder()
//
//                let deData = try decoder.decode(Club.self, from: data)
//
//                //completionHandler(deData) // User 하나를 return
//
//            }catch let err {
//                print("ERROR", err)
//            }
//
//        }.resume()
//    }
    
    func getAllClubs(clubs: String, completionHandler: @escaping (_ result: [Club]) -> ()) {
        let url_URL = URL(string: "\(APIAddress.address)/club")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
    
                let deData = try decoder.decode([Club].self, from: data)
                completionHandler(deData) // Club 전체
                
            }catch let err {
                print("ERROR", err)
            }
            
        }.resume()
    }
    
    func getUserProfile(){
        let url  = URL(string: "\(APIAddress.address)/user")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
             
                    // Convert HTTP Response Data to a String
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response data string:\n \(dataString)")
                    }
        }
        task.resume()
        
    }
    

    func getUserByKey(userId: Int64, userEmail: String, completionHandler: @escaping (_ result: User) -> ()) {
        // check user if already registered
        let url_URL = URL(string: "\(APIAddress.address)/user")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
        request.setValue(String(userId), forHTTPHeaderField: "id")
        request.setValue(userEmail, forHTTPHeaderField: "email")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
    
                let deData = try decoder.decode(User.self, from: data)
                completionHandler(deData) // User 하나를 return
                
            }catch let err {
                print("ERROR", err)
            }
            
        }.resume()
    }
    
        
    func postUser(userName: String, userEmail: String){
        let json: [String: Any] = ["name": userName,"email" : userEmail, "clubs" : ""]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url_URL = URL(string: "\(APIAddress.address)/user")
        
        var request = URLRequest(url: url_URL!)
    
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
     
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("[Rest API] postUser : \(dataString)")
            }
        }
        
        task.resume()
    }
    
    func getUserById(userId: Int, completionHandler: @escaping (_ result: Data) -> ()) {
        // check user if already registered
        let url_URL = URL(string: "\(APIAddress.address)/user")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
       
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data=data, let dataString = String(data: data, encoding: .utf8) {
                
                print("[Rest API] getAllClubs : \(dataString)")
                completionHandler(data)

            }
        }
        task.resume()
    }
    

    

}



struct APIAddress {
    static let address = "http://3.36.64.38:47000"
}

