//
// Created by Dossymkhan Zhulamanov on 05.07.2022.
//

import UIKit


class SplitViewController: UISplitViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        maximumPrimaryColumnWidth = 256
    }
}
