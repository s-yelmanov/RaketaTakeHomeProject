//
//  UIView+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
}

