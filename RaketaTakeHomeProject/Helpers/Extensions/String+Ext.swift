//
//  String+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

extension String {

    var isImageType: Bool {
        guard let url = URL(string: self) else { return false }
        
        let pathExtension = url.pathExtension

        return ImageType(rawValue: pathExtension) != nil
    }

}
