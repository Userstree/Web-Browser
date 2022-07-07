//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit
import WebKit

class SecondaryViewController: BaseViewController {

    var websiteTitle: String = "Apple" {
        didSet {
            navigationItem.title = websiteTitle
        }
    }
    var isLiked: Bool = false {
        didSet {
            if isLiked {
                navigationItem.rightBarButtonItem = UIBarButtonItem(
                        image: UIImage(systemName: "heart.fill"),
                        style: .plain,
                        target: self,
                        action: #selector(likeButtonTapped)
                )
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(
                        image: UIImage(systemName: "heart"),
                        style: .plain,
                        target: self,
                        action: #selector(likeButtonTapped)
                )
            }
            navigationItem.rightBarButtonItem?.tintColor = .red
        }
    }

    private var webPageURL: URL
    private let httpString = "https://"
    var webPageURLString: String = "" {
        didSet {
            webPageURL = URL(string: httpString + webPageURLString)!
            startWebView()
        }
    }

    init(webPageUrlString: String) {
        let urlString = httpString + webPageUrlString
        self.webPageURL = URL(string: urlString)!
        super.init(nibName: nil, bundle: nil)
    }

    convenience init() {
        self.init(webPageUrlString: "apple.com")
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) hasn't been implemented")
    }

    private var webView: WKWebView = {
        let view = WKWebView(autoResMasksOnConstraints: false)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        configureViews()
        startWebView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationItem.rightBarButtonItem?.tintColor = .red
    }

    private func configureNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "heart"),
                style: .plain,
                target: self,
                action: #selector(likeButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red
        navigationItem.title = websiteTitle
    }

    @objc private func likeButtonTapped() {
        isLiked = !isLiked
    }

    private func startWebView() -> WKNavigation? {
        webView.load(URLRequest(url: webPageURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: .zero))
    }

    private func configureViews() {
        view.addSubview(webView)

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

