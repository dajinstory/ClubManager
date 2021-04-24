//
//  LogoViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/04/24.
//

import UIKit
import SwiftyGif

class LogoViewController: UIViewController {
    
   
    let logoView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoView)
        print("logo view did load")
        //logoView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        logoView.pinEdgesToSuperView()
        logoView.logoGifImageView.delegate = self
    }


    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            logoView.logoGifImageView.startAnimatingGif()
        }

}

extension LogoViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoView.isHidden = true
        
        
        
        let navVC = UIStoryboard(name: Constants.Storyboard.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "root") as! UINavigationController

        //let navVC = UINavigationController(rootViewController: loginVC)
        UIApplication.shared.windows.first?.rootViewController = navVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
}

class LogoAnimationView: UIView {
    
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "club_manager.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
    }
}

