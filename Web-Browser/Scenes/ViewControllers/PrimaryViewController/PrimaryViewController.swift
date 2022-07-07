//
//  ViewController.swift
//  Web-Browser
//
//  Created by Dossymkhan Zhulamanov on 05.07.2022.
//

import UIKit

class PrimaryViewController: UIViewController, ViewControllerDelegate {
    var websites = [String]()
    private var webSitesTableViewDelegate: TableViewDelegate?
    private var webSitesTableViewDataSource: TableViewDataSource?

    private var websitesSegmentedControl: UISegmentedControl = {
        let items = ["List", "Favorite"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private let websitesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
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

    }

    func selectedCell(index: Int) {
        print("row at ", index)
    }

    private func configureViews() {
        webSitesTableViewDelegate = TableViewDelegate(withDelegate: self)
        webSitesTableViewDataSource = TableViewDataSource(withData: websites)
        websitesTableView.delegate = webSitesTableViewDelegate
        websitesTableView.dataSource = webSitesTableViewDataSource

        [websitesSegmentedControl, websitesTableView].forEach(view.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            websitesSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            websitesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            websitesSegmentedControl.widthAnchor.constraint(equalToConstant: 100),
            websitesSegmentedControl.heightAnchor.constraint(equalToConstant: 25),

            websitesTableView.topAnchor.constraint(equalTo: websitesSegmentedControl.topAnchor, constant: 10),
            websitesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            websitesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            websitesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

