//
// Created by Dossymkhan Zhulamanov on 07.07.2022.
//

import Foundation

protocol TableCellDataSource {
    var title:      String { get set }
    var isLiked:    Bool { get set }
    var urlString:  String { get set }
}

class Website: TableCellDataSource {
    var title: String = ""
    var urlString: String = ""
    var isLiked: Bool = false

    init(title: String, urlString: String, isLiked: Bool) {
        self.title = title
        self.urlString = urlString
        self.isLiked = isLiked
    }
}