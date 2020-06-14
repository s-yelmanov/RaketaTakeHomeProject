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
}

final class TopListViewModel {

    // MARK: - Private properties

    private let coordinator: TopListCoordinator
    private let service: RedditService

    private lazy var validator = ImageTypeValidator()

    private var items = [RedditTopDataChildrenResponse]()

    // MARK: - Properties

    weak var delegate: TopListViewModelDelegate?

    let title = "Top posts"
    var numberOfItems: Int {
        items.count
    }

    // MARK: - Life cycle

    init(coordinator: TopListCoordinator, service: RedditService) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Networking

    func fetchTopPosts() {
        service.getTopPosts { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.items = response.data.children
                self.delegate?.topListViewModelShouldReloadData(self)
            case .failure(let error):
                print(error.localizedDescription)
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
