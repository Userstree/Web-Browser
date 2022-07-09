//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit


class TableViewDataSource: NSObject, UITableViewDataSource, WebsiteLikeButtonDelegate {
    var favoriteWebsitesList = [Website]()
    var data = [Website]() {
        didSet {
//            print("dataHasChanged \n")
        }
    }

    private var viewModel: ViewModel!

    init(viewModel: ViewModel) {
        data = viewModel.websitesList
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.websitesList.count
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
            favoriteWebsitesList.append(data[index])
            data[index].isLiked = !data[index].isLiked
        } else {
//            favoriteWebsitesList.popLast()
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.remove(website: viewModel.websitesList[indexPath.row])
            data.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
