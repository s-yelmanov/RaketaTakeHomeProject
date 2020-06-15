//
//  ImageDetailsCoordinator.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class ImageDetailsCoordinator: Coordinator {

    // MARK: - Private properties

    private let navigationController: UINavigationController
    private let imageURL: String

    // MARK: - Life cycle

    init(navigationController: UINavigationController, imageURL: String) {
        self.navigationController = navigationController
        self.imageURL = imageURL
    }

    // MARK: - Methods

    func start() {
        let imageDetailsViewModel = ImageDetailsViewModel(coordinator: self, imageURL: imageURL)
        let imageDetailsController = UIStoryboard.instantiateImageDetailsViewController(
            viewModel: imageDetailsViewModel)
        
        let navigationController = LightStatusBarNavigationController(rootViewController: imageDetailsController)

        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve

        self.navigationController.present(navigationController, animated: true)
    }
    
}
