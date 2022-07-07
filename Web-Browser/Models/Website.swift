//
// Created by Dossymkhan Zhulamanov on 07.07.2022.
//

import Foundation

protocol TableCellDataSource {
    var title:      String { get set }
    var isLiked:    Bool { get set }
    var urlString:  String { get set }
}

struct Website: TableCellDataSource {
    var title: String = ""
    var urlString: String = ""
    var isLiked: Bool = false
}