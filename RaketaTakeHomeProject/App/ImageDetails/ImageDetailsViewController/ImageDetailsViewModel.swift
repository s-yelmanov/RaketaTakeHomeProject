//
//  ImageDetailsViewModel.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

protocol ImageDetailsViewModelDelegate: class {
    func imageDetailsViewModel(
        _ imageDetailsViewModel: ImageDetailsViewModel,
        didFinishSavingWithErrorMessage message: String?)
    func imageDetailsViewModelShouldRequestAccess(
        _ imageDetailsViewModel: ImageDetailsViewModel)
}

final class ImageDetailsViewModel {

    // MARK: - Private properties

    private let coordinator: ImageDetailsCoordinator
    private(set) var imageURL: String

    private lazy var imageWriter = ImageGalleryWriter()
    private lazy var photoLibraryPermissionService = PhotoLibraryPermissionService()

    // MARK: - Properties

    weak var delegate: ImageDetailsViewModelDelegate?

    // MARK: - Life cycle

    init(coordinator: ImageDetailsCoordinator, imageURL: String) {
        self.coordinator = coordinator
        self.imageURL = imageURL
    }

    // MARK: - Methods
    
    func saveImageToGallery(_ image: UIImage?) {
        photoLibraryPermissionService.checkPermission { [weak self] isGranted in
            guard let self = self else { return }
            
            guard isGranted else {
                self.delegate?.imageDetailsViewModelShouldRequestAccess(self)
                return
            }

            guard let image = image else {
                self.delegate?.imageDetailsViewModel(
                    self,
                    didFinishSavingWithErrorMessage: "Something went wrong. Please try again later.")
                return
            }

            self.imageWriter.delegate = self
            self.imageWriter.saveImageToGallery(image)
        }
    }
    
}

    // MARK: - Image gallery writer delegate

extension ImageDetailsViewModel: ImageGalleryWriterDelegate {

    func imageGalleryWriter(
        _ imageGalleryWriter: ImageGalleryWriter,
        didFinishSavingWithError error: Error?
    ) {
        delegate?.imageDetailsViewModel(self, didFinishSavingWithErrorMessage: error?.localizedDescription)
    }

}
