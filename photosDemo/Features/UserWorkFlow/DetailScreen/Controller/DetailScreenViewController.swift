//
//  DetailScreenViewController.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import UIKit

class DetailScreenViewController: UIViewController {
    static var identifier: String { return String(describing: self) }
    static var storyboard: String = "DetailScreen"
    // Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    // Properties
    var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    /// setup the view controller's ui
    private func setup() {
        // ImageView Setup
        backgroundImageView.contentMode = .scaleAspectFit
        // Download Image
        guard let imageURL = URL(string: url) else { return }
        backgroundImageView.af.setImage(withURL: imageURL)
    }
}
