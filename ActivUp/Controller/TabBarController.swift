//
//  TabBarController.swift
//  ActivUp
//
//  Created by Anel Rustamova on 05.12.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let isF = IsFirstDataManager.shared.fetchIsFirst()
        
        UITabBar.appearance().tintColor = UIColor.systemPurple
        if traitCollection.userInterfaceStyle == .dark {
            
            UITabBar.appearance().unselectedItemTintColor = UIColor.white
        }
        else {
            UITabBar.appearance().unselectedItemTintColor = UIColor.black
        }
        if (!isF) {
            let new = self.storyboard?.instantiateViewController(withIdentifier: "startViewController") as? StartViewController
            new!.modalPresentationStyle = .fullScreen
            self.present(new!, animated : false, completion : nil)
        }
        else {
            IsFirstDataManager.shared.saveTrue()
        }
    }
    



}
