//
//  TopListCoordinator.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class TopListCoordinator: Coordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let topListViewModel = TopListViewModel(coordinator: self, service: RedditService())
        let topListViewController = UIStoryboard.instantiateTopListViewController(viewModel: topListViewModel)
        
        navigationController.setViewControllers([topListViewController], animated: true)
    }

    func showImageDetails(with imageURL: String) {
        let imageDetailsCoordinator = ImageDetailsCoordinator(
            navigationController: navigationController,
            imageURL: imageURL)
        imageDetailsCoordinator.start()
    }
    
}
