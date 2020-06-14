//
//  AlertService.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

struct AlertService {

    static func showAlert(
        vc: UIViewController,
        title: String?,
        message: String? = nil,
        completionHandler:(()->())? = nil
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completionHandler?()
            }

            alert.addAction(okAction)

            vc.present(alert, animated: true)
        }
    }

    static func showSettingsAlert(
        vc: UIViewController,
        title: String?,
        message: String? = nil
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }

            let notNowAction = UIAlertAction(title: "Not now", style: .default)

            alert.addAction(notNowAction)
            alert.addAction(settingsAction)

            vc.present(alert, animated: true)
        }
    }

}
