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
    
    var userName = ""
    
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
                let fullName = user.profile.name,
                let givenName = user.profile.givenName,
                let familyName = user.profile.familyName,
                let email = user.profile.email {
                userName = fullName
                print("Token : \(idToken)")
                print("User ID : \(userId)")
                print("User Email : \(email)")
                print("User Name : \((fullName))")
                //postUSer()
         
            } else {
                print("Error : User Data Not Found")
            }
        self.segueToClub()
    }
    
    func postUSer(){
        print("post user")
        let json: [String: Any] = ["name": userName, "clubs" : ""]
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
                        print("Response data string:\n \(dataString)")
                    }
        }
        
        task.resume()
    }
    
    // 구글 로그인 연동 해제했을때 불러오는 메소드
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
        button.addTarget(self, action: #selector(onGoogleLoginByAppTouched), for: .touchUpInside)
        return button
    }()
    
    @objc func onKakaoLoginByAppTouched(_ sender: Any) {
        print("enetered")
        if(UserApi.isKakaoTalkLoginAvailable()){ // 이용가능하다면
            print("isKakaoTalkLoginAvailable")
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                print("loginWithKakaoTalk")
                    if let error = error {
                        print("error : ", error)
                    }
                    else {
                        print("loginWithKakaoTalk() success.")

                        //do something
                        _ = oauthToken
                        let accessToken = oauthToken?.accessToken
                        //토큰 발급 후 사용자 관리 api 호출
                        self.setUserInfo()
                    }
                }
        }
        
//
//        if kakaoLoginSuccess == true {
//            print("here")
//            let showClub = self.storyboard?.instantiateViewController(withIdentifier: "Club")
//            self.navigationController?.pushViewController(showClub!, animated: true)
//        }
    }
    
    
    func setUserInfo(){
        UserApi.shared.me(){(user, error) in
            if let error = error {
                print(error)
            }else{
                print("me() success")
                _ = user
                let userId = user?.id
                let userName = user?.kakaoAccount?.profile?.nickname
                let userEmail = user?.kakaoAccount?.email
                print("user info : \(String(describing: userId)) \(userName) \(userEmail)")
                
                print("segueToClub")
                self.segueToClub()
//                let club = ClubViewController()
//                club.modalPresentationStyle = .fullScreen
//                self.present(club, animated: true)
                //self.navigationController?.pushViewController(club, animated: true)
                
            }
        }
    }
    
    @objc func onGoogleLoginByAppTouched(){
        
    }
    
    func segueToClub(){
        print("segueToClub")
        let club = ClubViewController()
        self.navigationController?.pushViewController(club, animated: true)
        
    }
    
//    private let loginButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
//        button.setTitle("Log in", for: .normal)
//        button.backgroundColor = .white
//        button.setTitleColor(.black, for: .normal)
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        view.addSubview(kakaoTalkLoginButton)
        view.addSubview(googleLoginButton)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        kakaoTalkLoginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        kakaoTalkLoginButton.center = view.center
        googleLoginButton.frame = CGRect(x: kakaoTalkLoginButton.frame.minX, y: kakaoTalkLoginButton.bottom + 30, width: 250, height: 40)
       
        
    }
    

    


}
