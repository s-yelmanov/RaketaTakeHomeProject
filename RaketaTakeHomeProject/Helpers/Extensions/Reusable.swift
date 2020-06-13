//
//  Reusable.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    func dequeueReusableCell<Cell: Reusable>(type: Cell.Type) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? Cell else {
            fatalError("Failed to dequeue cell with identifier: " + Cell.reuseIdentifier)
        }

        return cell
    }

    func register<Cell: UITableViewCell>(type: Cell.Type) {
        register(
            UINib(nibName: Cell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: Cell.reuseIdentifier)
    }

}
