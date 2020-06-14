//
//  TopListTableViewCell.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class TopListTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var numberOfCommentsLabel: UILabel!

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.roundCorners()
    }

    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }

    // MARK: - Setup
    
    func setup(item: RedditTopItemResponse) {
        thumbnailImageView.loadImage(fromURL: item.thumbnail)
        authorNameLabel.text = item.author
        timeLabel.text = item.timeString
        titleLabel.text = item.title
        numberOfCommentsLabel.text = "\(item.numberOfComments)"
    }

}
