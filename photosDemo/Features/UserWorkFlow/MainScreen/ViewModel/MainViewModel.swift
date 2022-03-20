//
//  MainViewModel.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import Foundation
import UIKit

protocol MainViewModelDelegate: AnyObject {
    func didFinishContentUpdate()
    func showDetailScreenWith(url: String)
}

class MainViewModel {

    // Service
    private let photoService: PhotoService!
    weak var delegate: MainViewModelDelegate?
    // UI Class Components
    var photosTableViewManager: PhotosTableViewManager!
    // Properties
    var photos: [Photo] = []

    /// viewmodel's  init method
    /// - Parameter service: the injected service to be used in the viewmodel
    init(service: PhotoService) {
        photoService = service
        photosTableViewManager = PhotosTableViewManager(viewModel: self)
        photosTableViewManager.delegate = self
    }

    /// public method to get the photos from the api, gets the data and updates the viewmodel's photos array, then calls the delegate
    func getPhotos() {
        photoService.getPhotos { [weak self] result in
            guard let downloadedPhotos = try? result.get() as? [Photo] else { return }
            self?.photos.removeAll()
            self?.photos.append(contentsOf: downloadedPhotos)
            self?.delegate?.didFinishContentUpdate()
        }
    }
}

extension MainViewModel: PhotosTableViewManagerDelegate {
    func showDetailScreenWith(url: String) {
        delegate?.showDetailScreenWith(url: url)
    }
}
