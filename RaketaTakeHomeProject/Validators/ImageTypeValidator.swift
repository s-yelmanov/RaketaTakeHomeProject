//
//  ImageTypeValidator.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

struct ImageTypeValidator {

    func validate(_ urlString: String?) -> String? {
        guard let urlString = urlString, urlString.isImageType else { return nil }

        return urlString
    }
    
}
