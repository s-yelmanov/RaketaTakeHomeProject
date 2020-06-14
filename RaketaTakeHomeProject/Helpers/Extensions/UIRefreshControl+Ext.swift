//
//  UIRefreshControl+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIRefreshControl {

    func stopRefreshingOnMainThread() {
        DispatchQueue.main.async {
            if self.isRefreshing {
                self.endRefreshing()
            }
        }
    }

}
