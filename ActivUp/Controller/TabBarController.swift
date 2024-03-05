import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        IsFirstDataManager.shared.saveTrue()
        UITabBar.appearance().tintColor = UIColor.systemPurple
        if traitCollection.userInterfaceStyle == .dark {
            UITabBar.appearance().unselectedItemTintColor = UIColor.white
        }
        else {
            UITabBar.appearance().unselectedItemTintColor = UIColor.black
        }

    }
}
