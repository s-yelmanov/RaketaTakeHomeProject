//
//  TopListViewController.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class TopListViewController: UIViewController {

    // MARK: - Properties

    var viewModel: TopListViewModel!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = viewModel.title
    }

}
