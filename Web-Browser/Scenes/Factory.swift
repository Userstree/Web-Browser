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
        let navigationController = UINavigationController(rootViewController: primaryViewController)
        let secondaryViewController = SecondaryViewController()

        let splitViewController = SplitViewController()
        splitViewController.viewControllers = [navigationController, secondaryViewController]
        return splitViewController
    }
}
