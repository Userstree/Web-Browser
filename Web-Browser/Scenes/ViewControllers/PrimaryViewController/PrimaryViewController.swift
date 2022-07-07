//
//  ViewController.swift
//  Web-Browser
//
//  Created by Dossymkhan Zhulamanov on 05.07.2022.
//

import UIKit

class PrimaryViewController: BaseViewController, TableViewControllerDelegate, AlertViewPresentable {
    var websitesList = [
        Website(title: "Apple", urlString: "apple.com", isLiked: false),
        Website(title: "YouTube", urlString: "youtube.com", isLiked: false),
    ]
    private var webSitesTableViewDelegate: TableViewDelegate?
    private var webSitesTableViewDataSource: TableViewDataSource? = nil {
        didSet {
            websitesTableView.reloadData()
        }
    }

    private var websitesSegmentedControl: UISegmentedControl = {
        let items = ["List", "Favorite"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
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

    @objc private func addBarButtonTapped() {
        presentAddWebSiteActivity { [unowned self] websiteTitleString, websiteURLString in
            websitesList.append(Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
            webSitesTableViewDataSource?.data.append(Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
            websitesTableView.reloadData()
            print(websiteTitleString, " and ", websiteURLString)
        }
    }

    func selectedCell(index: Int) {
        print(websitesList.count, " and index is ", index)
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