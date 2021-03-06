//
//  SlideMenuController.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/03/05.
//

import UIKit
import SideMenu

class CustomSideMenuNavigation: SideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationStyle = .menuSlideIn

    }
    
}
