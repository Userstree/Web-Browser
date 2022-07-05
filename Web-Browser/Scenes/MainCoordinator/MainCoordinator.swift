//
// Created by Dossymkhan Zhulamanov on 05.07.2022.
//

import UIKit


class MainCoordinator: UIViewController, Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ViewContro
    }

}
