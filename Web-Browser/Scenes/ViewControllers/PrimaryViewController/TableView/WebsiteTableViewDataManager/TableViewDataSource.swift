//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit


class TableViewDataSource: NSObject, UITableViewDataSource, WebsiteLikeButtonDelegate {
    var websitesList = [
        Website(title: "Apple", urlString: "apple.com", isLiked: false),
        Website(title: "YouTube", urlString: "youtube.com", isLiked: false),
    ]
    var favoriteWebsitesList = [Website]()
    var data = [Website]() {
        didSet {
            print("dataHasChanged")
        }
    }

    override init() {
        data = websitesList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WebsiteTableViewCell.identifier, for: indexPath) as! WebsiteTableViewCell
        cell.configure(with: data[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }

    func didTapLiked(atIndex index: Int, isLiked: Bool) {
        if isLiked {
            favoriteWebsitesList.append(websitesList[index])
        } else {
//            favoriteWebsitesList.popLast()
        }
    }
}
