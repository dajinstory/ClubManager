//
//  loginViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/02/16.
//

import UIKit

class loginViewController: UIViewController {
    
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
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

    }
    
    //show all about club
    @objc func didTapLoginButton(){
        let showClub = self.storyboard?.instantiateViewController(withIdentifier: "showClub")
        self.navigationController?.pushViewController(showClub!, animated: true)
//        let showClub = UIViewController()
//        present(showClub, animated: true)
    }
    


}
