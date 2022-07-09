//
// Created by Dossymkhan Zhulamanov on 09.07.2022.
//

import Foundation

protocol ViewModel {
    var websitesList: [Website] { get set }
    func append(website: Website)
    func remove(website: Website)
}