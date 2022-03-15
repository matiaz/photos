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

    private func setup() {
        // ViewModel Setup
        viewModel = MainViewModel(service: PhotoService())
        viewModel.delegate = self
        // Navigation Controller Setup
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Images".localized
        // TableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        // Refresh Control Setup
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh".localized)
        refreshControl.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)
        tableView.addSubview(refreshControl)
        // Get Photos
        viewModel.getPhotos(on: tableView)
    }

    @objc private func refreshPhotos(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        viewModel.getPhotos(on: tableView)
    }

    private func showDetailScreenWith(url: String) {
        let storyboard = UIStoryboard(name: DetailScreenViewController.storyboard, bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: DetailScreenViewController.identifier) as? DetailScreenViewController {
            viewController.url = url
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier) as! ImageTableViewCell
        let photo = viewModel.photos[indexPath.row]
        photoCell.loadInformation(photo)
        return photoCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPhoto = viewModel.photos[indexPath.row]
        if let url = selectedPhoto.url {
            showDetailScreenWith(url: url)
        }
    }
}

extension ViewController: MainViewModelDelegate {
    func didFinishContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
}
