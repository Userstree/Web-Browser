//
// Created by Dossymkhan Zhulamanov on 07.07.2022.
//

import UIKit


protocol Factory {
    func makeViewController() -> UISplitViewController
}

class FactoryImpl: Factory {
    func makeViewController() -> UISplitViewController {
        let primaryViewController = PrimaryViewController()
        let primaryNavController = UINavigationController(rootViewController: primaryViewController)
        let secondaryViewController = SecondaryViewController()
        let secondaryNavController = UINavigationController(rootViewController: secondaryViewController)

        let splitViewController = SplitViewController()
        splitViewController.viewControllers = [primaryNavController, secondaryNavController]
        return splitViewController
    }
}
