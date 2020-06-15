//
//  AppCoordinator.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

protocol Coordinator {
  func start()
}

final class AppCoordinator: Coordinator {

    // MARK: - Private properties

    private let navigationController: UINavigationController
    private let window: UIWindow?

    // MARK: - Life cycle

    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: - Methods
    
    func start() {
        guard let window = window else {
            fatalError("Window is nil")
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showTopList()
    }

    private func showTopList() {
        let topListCoorinator = TopPostListCoordinator(navigationController: navigationController)
        topListCoorinator.start()
    }

}
