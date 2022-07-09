//
// Created by Dossymkhan Zhulamanov on 07.07.2022.
//

import UIKit


protocol Factory {
    func makeViewController() -> UISplitViewController
}

class FactoryImpl: Factory {
    func makeViewController() -> UISplitViewController {
        let viewModel = ViewModelImpl()
        let primaryViewController = PrimaryViewController(viewModel: viewModel)
        let primaryNavController = UINavigationController(rootViewController: primaryViewController)
        let secondaryViewController = SecondaryViewController()

        let splitViewController = SplitViewController()
        splitViewController.viewControllers = [primaryNavController, secondaryViewController]
        return splitViewController
    }
}
