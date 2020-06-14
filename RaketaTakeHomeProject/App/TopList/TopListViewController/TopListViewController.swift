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
            tableView.register(type: LoadingTableViewCell.self)
            
            tableView.tableFooterView = UIView()
            tableView.tableHeaderView = UIView()

            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    // MARK: - Private properties

    private let refreshControl = UIRefreshControl()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        setupUI()
        setupRefreshControl()

        viewModel.fetchTopPosts()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = viewModel.title
    }

    private func setupRefreshControl() {
        extendedLayoutIncludesOpaqueBars = true
        
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(refreshControlAction),
            for: .valueChanged
        )

        refreshControl.tintColor = .darkGray
    }

    // MARK: - Actions

    @objc private func refreshControlAction() {
        viewModel.fetchTopPosts(isRefreshing: true)
    }

}

    // MARK: - Top  list view model delegate

extension TopListViewController: TopListViewModelDelegate {

    func topListViewModelShouldReloadData(_ topListViewModel: TopListViewModel) {
        refreshControl.stopRefreshingOnMainThread()
        tableView.reloadDataOnMainThread()
    }

    func topListViewModel(
        _ topListViewModel: TopListViewModel,
        failedToLoadDataWithMessage message: String
    ) {
        AlertService.showAlert(
            vc: self,
            title: "Error",
            message: message
        )
        
        refreshControl.stopRefreshingOnMainThread()
    }

}

    // MARK: - Table view delegate

extension TopListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfItems - 5, !viewModel.isLoadingList {
            viewModel.fetchTopPosts()
        }
    }
    
}

    // MARK: - Table view data source

extension TopListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case viewModel.numberOfItems - 1:
            let cell: LoadingTableViewCell = tableView.dequeueReusableCell(type: LoadingTableViewCell.self)

            return cell
        default:
            if viewModel.numberOfItems != 0 {
                let cell: TopListTableViewCell = tableView.dequeueReusableCell(type: TopListTableViewCell.self)

                cell.setup(item: viewModel.itemAt(indexPath))

                return cell
            }
        }

        return UITableViewCell()
    }

}
