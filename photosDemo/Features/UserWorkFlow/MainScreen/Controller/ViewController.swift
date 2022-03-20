//
//  ViewController.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!

    // Properties
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    /// setup the view controller's ui
    private func setup() {
        // ViewModel Setup
        viewModel = MainViewModel(service: PhotoService())
        viewModel.delegate = self
        // Navigation Controller Setup
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Images".localized
        // TableView Setup
        tableView.delegate = viewModel.photosTableViewManager
        tableView.dataSource = viewModel.photosTableViewManager
        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        // Refresh Control Setup
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh".localized)
        refreshControl.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)
        tableView.addSubview(refreshControl)
        // Get Photos
        viewModel.getPhotos()
    }

    /// UIRefreshControl method to refresh the data
    /// - Parameter refreshControl: default UIRefreshControl
    @objc private func refreshPhotos(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        viewModel.getPhotos()
    }
}

extension ViewController: MainViewModelDelegate {

    /// a viewmodel's delegate method
    func didFinishContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }

    /// a viewmodel's delegate method
    func showDetailScreenWith(url: String) {
        let storyboard = UIStoryboard(name: DetailScreenViewController.storyboard, bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: DetailScreenViewController.identifier) as? DetailScreenViewController {
            viewController.url = url
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
