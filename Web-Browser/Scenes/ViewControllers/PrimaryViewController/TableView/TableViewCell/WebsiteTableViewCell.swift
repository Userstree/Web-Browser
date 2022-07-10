//
// Created by Dossymkhan Zhulamanov on 06.07.2022.
//

import UIKit

protocol WebsiteLikeButtonDelegate: AnyObject {
    func didTapLiked(atIndex index: Int, isLiked: Bool)
}

class WebsiteTableViewCell: UITableViewCell {
    static let identifier = "WebsiteTableViewCell"

    weak var delegate: WebsiteLikeButtonDelegate?
    private var cellIndex: Int = 0

    private var isLiked: Bool = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(systemName: "heart.fill")!, for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart")!, for: .normal)
            }
        }
    }

    private var title: UILabel = {
        let label = UILabel(autoResMasksOnConstraints: false)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton(autoResMasksOnConstraints: false)
        button.setImage(UIImage(systemName: "heart")!, for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.tintColor = .red
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    @objc private func likeButtonTapped() {
        isLiked = !isLiked
        delegate?.didTapLiked(atIndex: cellIndex,isLiked: isLiked)
    }

    func configure(with dataSource: TableCellDataSource, index: Int) {
        title.text = dataSource.title
        isLiked = dataSource.isLiked
        cellIndex = index
    }

    private func configureViews() {
        [title, likeButton].forEach(contentView.addSubview)
        makeConstraints()
    }
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
