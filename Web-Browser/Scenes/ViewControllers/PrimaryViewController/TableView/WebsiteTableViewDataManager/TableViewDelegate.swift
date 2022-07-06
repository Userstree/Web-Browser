//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func selectedCell(index: Int)
}

class TableViewDelegate: NSObject, UITableViewDelegate {
    weak var delegate: ViewControllerDelegate?

    init(withDelegate delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectedCell(index: indexPath.row)
    }
}
