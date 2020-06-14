//
//  TopListViewModel.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

protocol TopListViewModelDelegate: class {
    func topListViewModelShouldReloadData(_ topListViewModel: TopListViewModel)
    func topListViewModel(
        _ topListViewModel: TopListViewModel,
        failedToLoadDataWithMessage message: String)
}

final class TopListViewModel {

    // MARK: - Private properties

    private let coordinator: TopListCoordinator
    private let service: RedditService

    private lazy var validator = ImageTypeValidator()

    private var items = [RedditTopDataChildrenResponse]()
    private var lastPostID: String?
    private(set) var isLoadingList = false

    // MARK: - Properties

    weak var delegate: TopListViewModelDelegate?

    let title = "Top posts"
    var numberOfItems: Int {
        items.count + 1
    }

    // MARK: - Life cycle

    init(coordinator: TopListCoordinator, service: RedditService) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Networking

    func fetchTopPosts(isRefreshing: Bool = false) {
        if isRefreshing {
            lastPostID = nil
        }

        isLoadingList = true
        
        service.getTopPosts(lastPostID: lastPostID) { [weak self] result in
            guard let self = self else { return }

            self.isLoadingList = false

            switch result {
            case .success(let response):
                if isRefreshing {
                    self.items.removeAll()
                }
                
                self.lastPostID = response.data.after
                self.items.append(contentsOf: response.data.children)
                
                DispatchQueue.main.async {
                    self.delegate?.topListViewModelShouldReloadData(self)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.topListViewModel(
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
