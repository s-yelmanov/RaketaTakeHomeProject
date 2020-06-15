//
//  UIActivityIndicatorView+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 15.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {

    func stopAnimatingOnMainThread() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }

}
