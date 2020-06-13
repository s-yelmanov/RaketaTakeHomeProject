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

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(type: TopListTableViewCell.self)
            
            tableView.tableFooterView = UIView()
            tableView.tableHeaderView = UIView()

            tableView.rowHeight = UITableView.automaticDimension
        }
    }


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
    }

}

    // MARK: - Table view delegate

extension TopListViewController: UITableViewDelegate {}

    // MARK: - Table view data source

extension TopListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopListTableViewCell = tableView.dequeueReusableCell(type: TopListTableViewCell.self)

        return cell
    }

}
