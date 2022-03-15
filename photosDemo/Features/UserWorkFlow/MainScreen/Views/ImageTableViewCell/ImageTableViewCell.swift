//
//  ImageTableViewCell.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    // Properties
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setup() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }

    func loadInformation(_ photo: Photo) {
        albumLabel.text = "\("Album Id:".localized) \(photo.albumId ?? 0)"
        idLabel.text = "\("Identifier:".localized) \(photo.id ?? 0)"
        photoImageView.af.setImage(withURL: URL(string: photo.thumbnailUrl!)!)
    }
}
