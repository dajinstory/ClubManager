//
//  loginViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/16.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        view.backgroundColor = .systemGreen
        view.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.center = view.center
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchDown)

    }
    
    //show all about club
    @objc func didTapLoginButton(){
        print("button click")
//        let vc = showClubViewController()
//        let showClubVC = UINavigationController(rootViewController: vc)
       
//    let vc = showClubViewController()
//    self.navigationController?.pushViewController(vc, animated: true)
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "showClub") else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)


        
//    let showClubVC = self.storyboard?.instantiateViewController(withIdentifier: "showClub")
//    self.navigationController?.pushViewController(showClubVC!, animated: true)
        
//        guard let showClubVC = self.storyboard?.instantiateViewController(identifier: "showClub")
//                as?showClubViewController else {
//                    return
//                }
//
//        self.present(showClubVC, animated: true)
        
       
      
    }
    


}
