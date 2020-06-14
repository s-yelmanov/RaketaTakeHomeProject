//
//  UIStoryboard+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIStoryboard {

    private static var topList: UIStoryboard {
        return UIStoryboard(name: "TopList", bundle: nil)
    }

    private static var imageDetails: UIStoryboard {
        return UIStoryboard(name: "ImageDetails", bundle: nil)
    }
    
    static func instantiateTopListViewController(viewModel: TopListViewModel) -> TopListViewController {
        let topListViewController = topList.instantiateViewController(
            withIdentifier: String(describing: TopListViewController.self)) as! TopListViewController
        topListViewController.viewModel = viewModel
        
        return topListViewController
    }

    static func instantiateImageDetailsViewController(viewModel: ImageDetailsViewModel) -> ImageDetailsViewController {
        let imageDetailsViewController = imageDetails.instantiateViewController(
            withIdentifier: String(describing: ImageDetailsViewController.self)) as! ImageDetailsViewController
        imageDetailsViewController.viewModel = viewModel

        return imageDetailsViewController
    }

}
