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

enum ImageType: String {

    case jpg
    case png

    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "jpg", "jpeg":
            self = .jpg
        case "png":
            self = .png
        default:
            return nil
        }
    }

}

