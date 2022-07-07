//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func selectedCell(index: Int)
}

class TableViewDelegate: NSObject, UITableViewDelegate {
    weak var delegate: TableViewControllerDelegate?

    init(withDelegate delegate: TableViewControllerDelegate) {
        self.delegate = delegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectedCell(index: indexPath.row)
    }
}
