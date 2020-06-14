//
//  TopPostListViewModel.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

protocol TopPostListViewModelDelegate: class {
    func topPostListViewModelShouldReloadData(_ topPostListViewModel: TopPostListViewModel)
    func topPostListViewModel(
        _ topPostListViewModel: TopPostListViewModel,
        failedToLoadDataWithMessage message: String)
}

final class TopPostListViewModel {

    // MARK: - Private properties

    private let coordinator: TopPostListCoordinator
    private let service: RedditService

    private lazy var validator = ImageTypeValidator()

    private var items = [RedditTopDataChildrenResponse]()
    private(set) var paginationData = PaginationData()

    // MARK: - Properties

    weak var delegate: TopPostListViewModelDelegate?

    let title = "Top posts"
    var numberOfItems: Int {
        paginationData.hasMoreItemsToLoad ? items.count + 1 : items.count
    }

    // MARK: - Life cycle

    init(coordinator: TopPostListCoordinator, service: RedditService) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Networking

    func fetchTopPosts(isRefreshing: Bool = false) {
        if isRefreshing {
            paginationData.lastPostID = nil
        }

        paginationData.isLoadingList = true
        
        service.getTopPosts(lastPostID: paginationData.lastPostID) { [weak self] result in
            guard let self = self else { return }

            self.paginationData.isLoadingList = false

            switch result {
            case .success(let response):
                if isRefreshing {
                    self.items.removeAll()
                }

                self.paginationData.hasMoreItemsToLoad = !response.data.children.isEmpty
                self.paginationData.lastPostID = response.data.after
                self.items.append(contentsOf: response.data.children)
                
                DispatchQueue.main.async {
                    self.delegate?.topPostListViewModelShouldReloadData(self)
                }
            case .failure(let error):
                self.paginationData.hasMoreItemsToLoad = false
                DispatchQueue.main.async {
                    self.delegate?.topPostListViewModel(
                        self,
                        failedToLoadDataWithMessage: error.localizedDescription
                    )
                }
            }
        }
    }

    // MARK: - Methods
    
    func itemAt(_ indexPath: IndexPath) -> RedditTopItemResponse {
        items[indexPath.row].data
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let url = validator.validate(items[indexPath.row].data.url) else { return }
        showImageDetails(with: url)
    }

    private func showImageDetails(with imageURL: String) {
        coordinator.showImageDetails(with: imageURL)
    }
    
}
