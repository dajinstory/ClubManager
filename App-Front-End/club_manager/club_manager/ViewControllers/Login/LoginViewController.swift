//
//  loginViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoOpenSDK
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    //연도. 시도시 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("the user has not signed in before or they have since signed out ")
            }else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // 사용자 정보 가져오기
            if let userId = user.userID,                  // For client-side use only!
                let idToken = user.authentication.idToken, // Safe to send to the server
                let userName = user.profile.name,
                let userEmail = user.profile.email {
                
                getUserByKey( userId: 1, userEmail: userEmail) {
                    result in
                    if result == "" {
                        print("[Rest API] Create User\n")
                        self.postUser(userName: userName, userEmail: userEmail)
                    }
                    else {
                        print("[Rest API] User Already registered\n")

                    }
                }
                
               
            } else {
                print("Error : User Data Not Found")
            }
        
        self.segueToClub()
    }
    
//    typealias CompletionHandler = (_ result:String) -> (Void)
    
    func getUserByKey(userId: Int, userEmail: String, completionHandler: @escaping (_ result: String) -> ()) {
        // check user if already registered
        let url_URL = URL(string: "http://13.124.135.59:47000/user")
        var request = URLRequest(url: url_URL!)
        
        request.httpMethod = "GET"
        request.setValue(String(userId), forHTTPHeaderField: "id")
        request.setValue(userEmail, forHTTPHeaderField: "email")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data=data, let dataString = String(data: data, encoding: .utf8) {
                
                print("[Rest API] getUserByKey : \(dataString)")
    
                completionHandler(dataString)
                
            }
        }
        task.resume()
    }
    
        
    func postUser(userName: String, userEmail: String){
        let json: [String: Any] = ["name": userName,"email" : userEmail, "clubs" : ""]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url_URL = URL(string: "http://13.124.135.59:47000/user")
        
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
    
    // 구글 로그인 연동 해제시
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }
    
    
    
    private let kakaoTalkLoginButton:KOLoginButton = {
        let button = KOLoginButton()
        button.addTarget(self, action: #selector(onKakaoLoginByAppTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .standard
        return button
    }()
    
    //kakao login
    @objc func onKakaoLoginByAppTouched(_ sender: Any) {
        if(UserApi.isKakaoTalkLoginAvailable()){ // 이용가능하다면
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        let token = oauthToken
                        guard token != nil else {
                            return
                        }
                        //print("login token \(gettoken)")
                        self.setUserInfo()
                    }
                }
        }
    }
    
    
    func setUserInfo(){
        UserApi.shared.me(){(user, error) in
            if let error = error {
                print(error)
            }else{
                print("me() success")
                _ = user
    
                guard let userName = user?.kakaoAccount?.profile?.nickname else { return }
                guard let userEmail = user?.kakaoAccount?.email else { return }
                self.postUser(userName: userName, userEmail: userEmail)
                self.segueToClub()
              
            }
        }
    }

    func segueToClub(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "Club") else{
            return
        }
        let navVC = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()

//        let club = ClubViewController()
//        self.navigationController?.pushViewController(club, animated: true)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        title = "Log In"
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        view.addSubview(kakaoTalkLoginButton)
        view.addSubview(googleLoginButton)
        view.addSubview(loginButton)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        kakaoTalkLoginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        kakaoTalkLoginButton.center = view.center
        googleLoginButton.frame = CGRect(x: kakaoTalkLoginButton.frame.minX, y: kakaoTalkLoginButton.bottom + 30, width: 250, height: 40)
        loginButton.frame = CGRect(x: kakaoTalkLoginButton.frame.minX, y: googleLoginButton.bottom + 30 , width: 250, height: 40)
    }
    
    @objc func didTapLoginButton(){
        self.segueToClub()
    }

}
