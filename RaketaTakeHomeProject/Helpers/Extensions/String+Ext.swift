//
//  String+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

extension String {

//    var isImageType: Bool {
//        guard let url = URL(string: self) else { return false }
//        
//        let pathExtension = url.pathExtension
//
//        return ImageType(rawValue: pathExtension) != nil
//    }

    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }

}
