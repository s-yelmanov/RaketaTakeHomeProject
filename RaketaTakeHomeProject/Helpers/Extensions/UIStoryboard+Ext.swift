//
//  UIStoryboard+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIStoryboard {

    private static var topPostList: UIStoryboard {
        return UIStoryboard(name: "TopPostList", bundle: nil)
    }

    private static var imageDetails: UIStoryboard {
        return UIStoryboard(name: "ImageDetails", bundle: nil)
    }
    
    static func instantiateTopListViewController(viewModel: TopPostListViewModel) -> TopPostListViewController {
        let topPostListViewController = topPostList.instantiateViewController(
            withIdentifier: String(describing: TopPostListViewController.self)) as! TopPostListViewController
        topPostListViewController.viewModel = viewModel
        
        return topPostListViewController
    }

    static func instantiateImageDetailsViewController(viewModel: ImageDetailsViewModel) -> ImageDetailsViewController {
        let imageDetailsViewController = imageDetails.instantiateViewController(
            withIdentifier: String(describing: ImageDetailsViewController.self)) as! ImageDetailsViewController
        imageDetailsViewController.viewModel = viewModel

        return imageDetailsViewController
    }

}
