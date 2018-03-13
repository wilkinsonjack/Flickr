//
//  PhotoCollectionViewController+PhotoCollectionViewCellDelegate.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import UIKit

extension PhotoCollectionViewController: PhotoCollectionViewCellDelegate {
    func shareButtonDidTap(_ cell: PhotoCollectionViewCell) {
        guard let photo = cell.photo,
              let shareImage = cell.photoImageView.image
        else { return }

        let vc = UIActivityViewController(activityItems: [photo.shareMessage, shareImage], applicationActivities: [])
        present(vc, animated: true)
    }
}

extension PhotoContainer.Item {
    var shareMessage: String {
        return "Check out this latest photo from \(username)"
    }
}
