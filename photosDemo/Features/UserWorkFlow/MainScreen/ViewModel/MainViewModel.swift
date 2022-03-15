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
}

class MainViewModel {

    // Service
    private let photoService: PhotoService!
    weak var delegate: MainViewModelDelegate?

    // Properties
    var photos: [Photo] = []

    init(service: PhotoService) {
        photoService = service
    }

    func getPhotos(on tableView: UITableView) {
        photoService.getPhotos { [weak self] result in
            guard let downloadedPhotos = try? result.get() as? [Photo] else { return }
            self?.photos.removeAll()
            self?.photos.append(contentsOf: downloadedPhotos)
            self?.delegate?.didFinishContentUpdate()
        }
    }
}
