//
//  PhotoCollectionViewController.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var photoContainer: PhotoContainer? {
        didSet {
            title = photoContainer?.title
            collectionView?.reloadData()
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPhotos()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARK: Networking

    private func fetchPhotos() {
        loadingIndicator.startAnimating()

        PhotoService.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoContainer):
                    self?.photoContainer = photoContainer
                case .failure(_):
                    self?.presentErrorAlert()
                }

                self?.loadingIndicator.stopAnimating()
            }
        }
    }

    private func presentErrorAlert() {
        let alert = UIAlertController(title: "Oops", message: "Some thing has gone wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again?", style: .default, handler: { [weak self] _ in
            self?.fetchPhotos()
        }))
        present(alert, animated: true)
    }
    
    // MARK:- UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photoContainer = photoContainer
            else { return 0 }

        return photoContainer.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell,
              let photoContainer = photoContainer
        else { return UICollectionViewCell() }

        let photo = photoContainer.items[indexPath.item]
        cell.photo = photo

        return cell
    }

    // MARK:- UICollectionViewFlowLayout

    private let itemSpacing: CGFloat = 16
    private let sectionInsets =  UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    private var numberOfItems: CGFloat {
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) || traitCollection.horizontalSizeClass == .regular {
            return 2
        }

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (numberOfItems + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / numberOfItems

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
}


private extension String {
    static let reuseIdentifier = "photoCell"
}
