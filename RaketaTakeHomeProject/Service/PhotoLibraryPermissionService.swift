//
//  PhotoLibraryPermissionService.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Photos

struct PhotoLibraryPermissionService {

    func checkPermission(completionHandler: ((Bool) -> Void)?) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            completionHandler?(true)
        case .denied, .restricted :
            completionHandler?(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    completionHandler?(true)
                case .denied, .restricted:
                    completionHandler?(true)
                case .notDetermined:
                    completionHandler?(false)
                @unknown default:
                    completionHandler?(false)
                }
            }
        @unknown default:
            completionHandler?(false)
        }
    }

}
