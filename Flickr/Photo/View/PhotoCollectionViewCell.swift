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
    func shareButtonDidTap(_ cell: PhotoCollectionViewCell)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    weak var delegate: PhotoCollectionViewCellDelegate?

    var photo: PhotoContainer.Item? {
        didSet {
            guard let photo = photo
                else { return }

            titleLabel.text = photo.title
            photoImageView.sd_setImage(with: photo.media.m)
        }
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        delegate?.shareButtonDidTap(self)
    }
}
