//
//  TopPostListTableViewCell.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

protocol TopPostListTableViewCellDelegate: class {
    func topPostListTableViewCellImageTapped(_ topPostListTableViewCell: TopPostListTableViewCell)
}

final class TopPostListTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var numberOfCommentsLabel: UILabel!

    // MARK: - Properties

    weak var delegate: TopPostListTableViewCellDelegate?

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupGestures()
    }

    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }

    // MARK: - SetupUI
    
    func setup(item: RedditTopItemResponse) {
        thumbnailImageView.loadImage(fromURL: item.thumbnail)
        authorNameLabel.text = item.author
        timeLabel.text = item.timeString
        titleLabel.text = item.title
        numberOfCommentsLabel.text = "\(item.numberOfComments)"
    }

    private func setupUI() {
        containerView.roundCorners(by: 8)
        thumbnailImageView.roundCorners(by: 8)
    }

    private func setupGestures() {
        let thumbnailImageViewTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(thumbnailImageViewTapGestureAction))
        thumbnailImageView.addGestureRecognizer(thumbnailImageViewTapGesture)
    }

    // MARK: - Actions

    @objc private func thumbnailImageViewTapGestureAction() {
        delegate?.topPostListTableViewCellImageTapped(self)
    }

}
