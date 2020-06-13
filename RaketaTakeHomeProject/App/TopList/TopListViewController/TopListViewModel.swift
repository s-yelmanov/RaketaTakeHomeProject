//
//  TopListViewModel.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

final class TopListViewModel {

    private let coordinator: TopListCoordinator

    // MARK: - Properties

    let title = "Top"

    // MARK: - Life cycle

    init(coordinator: TopListCoordinator) {
        self.coordinator = coordinator
    }
    
}

