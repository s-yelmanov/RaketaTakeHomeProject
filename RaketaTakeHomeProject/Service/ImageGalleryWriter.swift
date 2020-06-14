//
//  ImageGalleryWriter.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

protocol ImageGalleryWriterDelegate: class {
    func imageGalleryWriter(
        _ imageGalleryWriter: ImageGalleryWriter,
        didFinishSavingWithError error: Error?)
}

final class ImageGalleryWriter: NSObject {

    // MARK: - Properties

    weak var delegate: ImageGalleryWriterDelegate?

    // MARK: - Life cycle

    override init() {}

    // MARK: - Methods

    func saveImageToGallery(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(
            image,
            self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)),
            nil
        )
    }

    // MARK: - Actions

    @objc private func image(
        _ image: UIImage,
        didFinishSavingWithError error: Error?,
        contextInfo: UnsafeRawPointer
    ) {
        delegate?.imageGalleryWriter(self, didFinishSavingWithError: error)
    }

}
