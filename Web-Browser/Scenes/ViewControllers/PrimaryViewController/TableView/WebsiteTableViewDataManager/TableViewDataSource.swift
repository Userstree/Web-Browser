//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit


class TableViewDataSource: NSObject, UITableViewDataSource {

    var data = [String]()

    init(withData data: [String]) {
        self.data = data
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
}
