//
//  PhotosTableView.swift
//  photosDemo
//
//  Created by dmatiaz on 18/3/22.
//

import Foundation
import UIKit

protocol PhotosTableViewManagerDelegate: AnyObject {
    func showDetailScreenWith(url: String)
}

class PhotosTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {

    var viewModel: MainViewModel!
    weak var delegate: PhotosTableViewManagerDelegate?

    init(viewModel: MainViewModel) {
        super.init()
        self.viewModel = viewModel
    }

    /// standard table view data source and delegate methods
    /// - Parameters:
    ///   - tableView: the photos tableview
    ///   - section: the tableview's section index
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    /// standard table view data source and delegate methods
    /// - Parameters:
    ///   - tableView: the photos tableview
    ///   - indexPath: the cell's indexpath
    /// - Returns: the cell with the data assigned to it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier) as! ImageTableViewCell
        let photo = viewModel.photos[indexPath.row]
        photoCell.loadInformation(photo)
        return photoCell
    }

    /// standard table view data source and delegate methods
    /// - Parameters:
    ///   - tableView: the photos tableview
    ///   - indexPath: the cell's indexpath
    /// - Returns: the tableview height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    /// standard table view data source and delegate methods
    /// - Parameters:
    ///   - tableView: the photos tableview
    ///   - indexPath: the cell's indexpath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPhoto = viewModel.photos[indexPath.row]
        if let url = selectedPhoto.url {
            delegate?.showDetailScreenWith(url: url)
        }
    }
}
