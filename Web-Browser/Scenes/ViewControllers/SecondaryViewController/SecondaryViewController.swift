//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit
import WebKit

class SecondaryViewController: UIViewController {

    private var webPageURL: URL?
    init(webPageUrlString: String) {
        let httpString = "https://"
        let urlString = httpString + webPageUrlString
        webPageURL = URL(string: urlString)!
    }
    convenience init() {
        self.init(webPageUrlString: "www.apple.com")
    }

    private var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    private func configureViews() {
        view.addSubview(webView)

        makeConstraints()
    }
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

