//
// Created by Dossymkhan Zhulamanov on 07.07.2022.
//

import UIKit


extension UIView {
    convenience init(autoResMasksOnConstraints: Bool = false) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = autoResMasksOnConstraints
    }
}
