//
//  ViewController.swift
//  Web-Browser
//
//  Created by Dossymkhan Zhulamanov on 05.07.2022.
//

import UIKit

typealias TableFunctionable = WebsiteLikeButtonDelegate & TableViewControllerDelegate

class PrimaryViewController: BaseViewController, TableFunctionable, AlertViewPresentable {
    private var categoryIndex: Int = 0 {
        didSet {
            if categoryIndex == 0 {
                webSitesTableViewDataSource?.data = websitesList
            } else {
                webSitesTableViewDataSource?.data = favoriteWebsitesList
            }
            websitesTableView.reloadData()
        }
    }

    var websitesList = [
        Website(title: "Apple", urlString: "apple.com", isLiked: false),
        Website(title: "YouTube", urlString: "youtube.com", isLiked: false),
    ]
    var favoriteWebsitesList = [Website]()

    private var webSitesTableViewDelegate: TableViewDelegate?
    private var webSitesTableViewDataSource: TableViewDataSource? = nil {
        didSet {
            websitesTableView.reloadData()
        }
    }

    private lazy var websitesSegmentedControl: UISegmentedControl = {
        let items = ["List", "Favorite"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(categoryIndexTapped(_:)), for: .valueChanged)
        return segmentedControl
    }()

    private let websitesTableView: UITableView = {
        let tableView = UITableView(autoResMasksOnConstraints: false)
        tableView.register(WebsiteTableViewCell.self, forCellReuseIdentifier: "WebsiteTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        configureViews()
    }

    private func configureNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
        navigationItem.title = "Websites"
    }

    @objc private func categoryIndexTapped(_ sender: UISegmentedControl) {
        categoryIndex = sender.selectedSegmentIndex
    }

    @objc private func addBarButtonTapped() {
        presentAddWebSiteActivity { [unowned self] websiteTitleString, websiteURLString in
            websitesList.append(Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
            webSitesTableViewDataSource?.data.append(Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
            websitesTableView.reloadData()
            print(websiteTitleString, " and ", websiteURLString)
        }
    }

    func didTapLiked(atIndex index: Int, isLiked: Bool) {
        if isLiked {
            favoriteWebsitesList.append(websitesList[index])
        } else {
            favoriteWebsitesList.remove(at: index)
        }
        print("favoriteWebsitesList is ", favoriteWebsitesList)
        websitesTableView.reloadData()
    }

    func selectedCell(index: Int) {
        let secondaryVC = parent?.splitViewController?.viewControllers[1] as! SecondaryViewController
        secondaryVC.webPageURLString = websitesList[index].urlString
    }

    private func configureViews() {
        webSitesTableViewDelegate = TableViewDelegate(withDelegate: self)
        webSitesTableViewDataSource = TableViewDataSource()
        websitesTableView.delegate = webSitesTableViewDelegate
        websitesTableView.dataSource = webSitesTableViewDataSource

        [websitesSegmentedControl, websitesTableView].forEach(view.addSubview)
        makeConstraints()
    }
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            websitesSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            websitesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            websitesTableView.topAnchor.constraint(equalTo: websitesSegmentedControl.bottomAnchor, constant: 10),
            websitesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            websitesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            websitesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}