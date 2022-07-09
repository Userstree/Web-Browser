//
//  ViewController.swift
//  Web-Browser
//
//  Created by Dossymkhan Zhulamanov on 05.07.2022.
//

import UIKit


class PrimaryViewController: BaseViewController, TableViewControllerDelegate, AlertViewPresentable {
    private var viewModel: ViewModel!

    init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var categoryIndex: Int = 0 {
        didSet {
            if categoryIndex == 0 {
                webSitesTableViewDataSource?.data = viewModel.websitesList
            } else {
                webSitesTableViewDataSource?.data = favoriteWebsitesList
            }
            websitesTableView.reloadData()
        }
    }

    var favoriteWebsitesList = [Website]()

    private var webSitesTableViewDelegate: TableViewDelegate?
    private var webSitesTableViewDataSource: TableViewDataSource? = nil {
        didSet {
            websitesTableView.reloadData()
            favoriteWebsitesList = webSitesTableViewDataSource!.favoriteWebsitesList
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
        favoriteWebsitesList = webSitesTableViewDataSource!.favoriteWebsitesList
    }

    @objc private func addBarButtonTapped() {
        presentAddWebSiteActivity { [unowned self] websiteTitleString, websiteURLString in
            viewModel.append(website: Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
//            websitesList.append(Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
            webSitesTableViewDataSource?.data.append(Website(title: websiteTitleString, urlString: websiteURLString, isLiked: false))
            websitesTableView.reloadData()
            print(websiteTitleString, " and ", websiteURLString)
        }
    }

    func selectedCell(index: Int) {
        let secondaryVC = splitViewController?.viewControllers[1] as! SecondaryViewController
        print("index of secondaryVC ", index)
        secondaryVC.webPageURLString = viewModel.websitesList[index].urlString
    }

    private func configureViews() {
        webSitesTableViewDelegate = TableViewDelegate(withDelegate: self)
        webSitesTableViewDataSource = TableViewDataSource(viewModel: viewModel)

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
