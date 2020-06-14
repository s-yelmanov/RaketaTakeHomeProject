//
//  UIImage+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(fromURL url: String?, completionHandler: ((Bool) -> Void)? = nil) {
        guard let imageURL = URL(string: url ?? "") else {
            completionHandler?(false)
            return
        }

        let session = URLSession.shared
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)

        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    completionHandler?(true)
                }
            } else {
                session.dataTask(with: request) { (data, response, error) in
                    if
                        let data = data,
                        let response = response,
                        error == nil,
                        ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                        let image = UIImage(data: data)
                    {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                            completionHandler?(true)
                        }
                    } else {
                        completionHandler?(false)
                    }
                }.resume()
            }
        }
    }

    func transition(toImage image: UIImage?) {
        UIView.transition(
            with: self, duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: {
                self.image = image
        },
            completion: nil)
    }

}
