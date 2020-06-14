//
//  TopPostListViewController.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class TopPostListViewController: UIViewController {

    // MARK: - Properties

    var viewModel: TopPostListViewModel!

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(type: TopPostListTableViewCell.self)
            tableView.register(type: LoadingTableViewCell.self)
            
            tableView.tableFooterView = UIView()
            tableView.tableHeaderView = UIView()
            tableView.separatorStyle = .none
            tableView.allowsSelection = false
            tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

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
        setupNavigationBar(
            titleColor: .mainText,
            backgoundColor: .secondaryBackground,
            tintColor: .mainText,
            title: viewModel.title
        )
    }

    private func setupRefreshControl() {
        extendedLayoutIncludesOpaqueBars = true
        
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(refreshControlAction),
            for: .valueChanged
        )

        refreshControl.tintColor = .refreshControl
    }

    // MARK: - Actions

    @objc private func refreshControlAction() {
        viewModel.fetchTopPosts(isRefreshing: true)
    }

}

    // MARK: - Top  list view model delegate

extension TopPostListViewController: TopPostListViewModelDelegate {

    func topPostListViewModelShouldReloadData(_ topListViewModel: TopPostListViewModel) {
        refreshControl.stopRefreshingOnMainThread()
        tableView.reloadDataOnMainThread()
    }

    func topPostListViewModel(
        _ topListViewModel: TopPostListViewModel,
        failedToLoadDataWithMessage message: String
    ) {
        AlertService.showAlert(
            vc: self,
            title: "Error",
            message: message
        )
        
        refreshControl.stopRefreshingOnMainThread()
        tableView.reloadDataOnMainThread()
    }

}

    // MARK: - Top list table view cell delegate

extension TopPostListViewController: TopPostListTableViewCellDelegate {

    func topPostListTableViewCellImageTapped(_ topListTableViewCell: TopPostListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: topListTableViewCell) else { return }
        viewModel.didSelectRowAt(indexPath)
    }

}

    // MARK: - Table view delegate

extension TopPostListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if
            viewModel.paginationData.hasMoreItemsToLoad,
            indexPath.row == viewModel.numberOfItems - 5,
            !viewModel.paginationData.isLoadingList
        {
            viewModel.fetchTopPosts()
        }
    }
    
}

    // MARK: - Table view data source

extension TopPostListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.paginationData.hasMoreItemsToLoad, viewModel.numberOfItems - 1 == indexPath.row {
            let cell: LoadingTableViewCell = tableView.dequeueReusableCell(type: LoadingTableViewCell.self)

            return cell
        }

        if viewModel.numberOfItems != 0 {
            let cell: TopPostListTableViewCell = tableView.dequeueReusableCell(type: TopPostListTableViewCell.self)

            cell.setup(item: viewModel.itemAt(indexPath))
            cell.delegate = self

            return cell
        }

        return UITableViewCell()
    }

}
