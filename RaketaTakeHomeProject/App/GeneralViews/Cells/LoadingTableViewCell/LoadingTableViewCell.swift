//
//  LoadingTableViewCell.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Life cycle

    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }
    
}
