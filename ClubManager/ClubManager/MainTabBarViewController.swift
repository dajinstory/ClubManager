//
//  MainTabBarViewController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/03/04.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
       
        
//        view.backgroundColor = .systemPurple
//        let images = ["house","bell", "person.circle", "star", "gear" ]
//
//        guard let items = self.tabBar.items else {
//            return
//        }
//
//        for x in 0..<items.count{
//            //items[x].badgeValue = "1"
//            items[x].image = UIImage(systemName : images[x])
//        }
        
        
//        self.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
//
//        vc1.title = "home"
//        vc2.title = "Queastion"
//        vc3.title = "setting"
//        vc4.title = "turtle"
//
   }
    
    //tabbar index
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//            if tabBarIndex == 0 {
//                print("1")
//                let vc1 = SearchViewController()
//                //let nv1 = UINavigationController(rootViewController: ClubViewController())
//                present(vc1, animated: true)
//            } else if (tabBarIndex == 1){
//                print("2")
//                let vc2 = WriteViewController()
//                present(vc2, animated: true)
//            }else if (tabBarIndex == 2){
//                print("3")
//                let vc3 = CalenderViewController()
//                present(vc3, animated: true)
//            }else if (tabBarIndex == 3){
//                print("4")
//                let vc4 = ProfileViewController()
//                present(vc4, animated: true)
//            }
//        
//    }

//}
