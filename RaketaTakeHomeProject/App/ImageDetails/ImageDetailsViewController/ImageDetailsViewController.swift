//
//  ImageDetailsViewController.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class ImageDetailsViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ImageDetailsViewModel!

    // MARK: - IBOutlets

    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
    }

    // MARK: - SetupUI

    private func setupUI() {
        view.backgroundColor = .black

        imageView.loadImage(fromURL: viewModel.imageURL)

        setupNavigationBar()
        setupNavigationItemButtons()
    }

    private func setupNavigationItemButtons() {
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            style: .plain, target: self,
            action: #selector(closeButtonAction)
        )
        closeButton.tintColor = .white

        navigationItem.leftBarButtonItem = closeButton

        let saveButton = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(saveButtonAction)
        )
        saveButton.tintColor = .white

        navigationItem.rightBarButtonItem = saveButton
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.view.backgroundColor = .clear
    }

    // MARK: - Actions

    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }

    @objc private func saveButtonAction() {
        viewModel.saveImageToGallery(imageView.image)
    }

}

    // MARK: - Image details view model delegate

extension ImageDetailsViewController: ImageDetailsViewModelDelegate {

    func imageDetailsViewModel(
        _ imageDetailsViewModel: ImageDetailsViewModel,
        didFinishSavingWithErrorMessage message: String?
    ) {
        guard let message = message else {
            navigationItem.rightBarButtonItem?.title = "Saved"
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }

        AlertService.showAlert(vc: self, title: "Save error", message: message)
    }

    func imageDetailsViewModelShouldRequestAccess(_ imageDetailsViewModel: ImageDetailsViewModel) {
        AlertService.showSettingsAlert(
            vc: self,
            title: "The app would like to access your gallery",
            message: "Give access to your gallery for saving images."
        )
    }

}
