//
//  PhotoCollectionViewCell.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    var photo: PhotoContainer.Item? {
        didSet {
            guard let photo = photo
                else { return }

            titleLabel.text = photo.title
            photoImageView.sd_setImage(with: photo.media.m)
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}
