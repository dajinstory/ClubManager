//
//  loginViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import KakaoOpenSDK
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    var user_Name = ""
    var user_email = ""
    var dataManger = DataManger()
    
    //for apple login button view
    private var appleLoginButtonView: UIStackView = {
        let appleLoginButtonView = UIStackView()
        appleLoginButtonView.backgroundColor = .systemGray
        return appleLoginButtonView
    }()
    
    //apple login button
    private let appleLoginButton:ASAuthorizationAppleIDButton = {
        let appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClick), for: .touchUpInside)
        return appleLoginButton
    }()
    
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

    //관리자용 Login button
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    

    //로그인 성공시
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("the user has not signed in before or they have since signed out ")
            }else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // 사용자 Post or 정보 가져오기
            if let userName = user.profile.name,
                let userEmail = user.profile.email {
                
                dataManger.getUserByKey( userId: 1, userEmail: userEmail) {
                    result in
                    if result == nil {
                        print("[Rest API] Create User\n")
                        self.dataManger.postUser(userName: userName, userEmail: userEmail)
                    }
                    else {
                        print("[Rest API] User Already registered\n")

                    }
                }
                self.autoLogin(UN: userName, UE: userEmail)
            } else {
                print("Error : User Data Not Found")
            }
        
        
        self.segueToClub()
    }
    
    
    // 구글 로그인 연동 해제시
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }
    
    
    
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
    
//                guard let userName = user?.kakaoAccount?.profile?.nickname else { return }
//                guard let userEmail = user?.kakaoAccount?.email else { return }
                
                // 사용자 Post or 정보 가져오기
                    if let userName = user?.kakaoAccount?.profile?.nickname ,
                        let userEmail = user?.kakaoAccount?.email {
                        
                        self.dataManger.getUserByKey( userId: 1, userEmail: userEmail) {
                            result in
                            if result == nil {
                                print("[Rest API] Create User\n")
                                self.dataManger.postUser(userName: userName, userEmail: userEmail)
                            }
                            else {
                                print("[Rest API] User Already registered\n")

                            }
                        }
                        self.autoLogin(UN: userName, UE: userEmail)
                    } else {
                        print("Error : User Data Not Found")
                    }

                self.segueToClub()
              
            }
        }
    }
    
    //Apple Login
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case  let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            guard let fullName = appleIDCredential.fullName else { return }
            guard let email = appleIDCredential.email else { return }
            print("Apple login")
            print("User ID : \(userIdentifier)")
            print("User Email : \(email)")
            print("User Name : \(fullName)")
            
            self.autoLogin(UN: fullName.givenName! + fullName.familyName!, UE: email)
            
//            Apple login
//            User ID : 001607.55c65d33ebb84ff184c665342a5eaa79.0712
//            User Email : spqjf12345@naver.com
//            User Name : givenName: SoJeong familyName: Jo
        default:
            break;
        }
        
       
        self.segueToClub()
        
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
        // Handle error.
    }
    
    @objc func appleLoginButtonClick(){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func segueToClub(){
        
        let vc = UIStoryboard.init(name: "ClubMain", bundle: nil).instantiateViewController(withIdentifier: "ClubViewController")
        
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkAutoLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        view.addSubview(kakaoTalkLoginButton)
        view.addSubview(googleLoginButton)
        view.addSubview(appleLoginButtonView)
        view.addSubview(loginButton)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        kakaoTalkLoginButton.frame = CGRect(x: 50, y: 300, width: 300, height: 50)
        googleLoginButton.frame = CGRect(x: 50, y: kakaoTalkLoginButton.bottom + 30, width: 300, height: 90)
        
        appleLoginButtonView.frame = CGRect(x: 50, y: googleLoginButton.bottom + 30, width: 300, height: 50)
        appleLoginButton.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        
        appleLoginButtonView.addArrangedSubview(appleLoginButton)
        
        loginButton.frame = CGRect(x: 50, y: appleLoginButtonView.bottom + 30 , width: 300, height: 50)
        
    }
    
    func checkAutoLogin(){
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            if let useremail = UserDefaults.standard.string(forKey: "userEmail") {
               print("has value in userDefaults")
                self.segueToClub()
          }
        }else{
            print("meet the condition")
        }
        
    }
    
    @objc func didTapLoginButton(){
        self.segueToClub()
    }
    
    func autoLogin(UN: String, UE: String){
        print("auto Login did")
        UserDefaults.standard.set(UN, forKey: "userName")
        UserDefaults.standard.set(UE, forKey: "userEmail")
    }

}
