//
//  ImageType.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

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
