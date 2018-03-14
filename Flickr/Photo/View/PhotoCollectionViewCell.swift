//
//  PhotoCollectionViewCell.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import UIKit
import SDWebImage

protocol PhotoCollectionViewCellDelegate: class {
    func shareButtonDidTap(_ cell: PhotoCollectionViewCell, button: UIButton)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateTakenLabel: UILabel!
    @IBOutlet weak var datePublishedLabel: UILabel!

    weak var delegate: PhotoCollectionViewCellDelegate?

    var photo: PhotoContainer.Item? {
        didSet {
            guard let photo = photo
                else { return }

            titleLabel.text = photo.title
            photoImageView.sd_setImage(with: photo.media.url)
            dateTakenLabel.text = "Taken: \(DateFormatter.ddMMyyyy.string(from: photo.dateTaken))"
            datePublishedLabel.text = "Published: \(DateFormatter.ddMMyyyyHHmm.string(from: photo.published))"
        }
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        delegate?.shareButtonDidTap(self, button: sender)
    }
}
