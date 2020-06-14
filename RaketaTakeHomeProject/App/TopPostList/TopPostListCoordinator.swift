//
//  TopPostListCoordinator.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class TopPostListCoordinator: Coordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let topPostListViewModel = TopPostListViewModel(coordinator: self, service: RedditService())
        let topPostListViewController = UIStoryboard.instantiateTopListViewController(viewModel: topPostListViewModel)
        
        navigationController.setViewControllers([topPostListViewController], animated: true)
    }

    func showImageDetails(with imageURL: String) {
        let imageDetailsCoordinator = ImageDetailsCoordinator(
            navigationController: navigationController,
            imageURL: imageURL)
        imageDetailsCoordinator.start()
    }
    
}
