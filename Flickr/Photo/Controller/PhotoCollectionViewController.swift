//
//  PhotoCollectionViewController.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import UIKit
import SafariServices

enum PhotoSortType {
    case dateTaken
    case datePublished
}

class PhotoCollectionViewController: UICollectionViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(fetchPhotos), for: .valueChanged)
        return control
    }()

    var photoContainer: PhotoContainer? {
        didSet {
            title = photoContainer?.title

            collectionView?.reloadData()
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItem = barButtonItem

        collectionView?.refreshControl = refreshControl
        fetchPhotos()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARL: Filtering

    @objc func filterTapped() {
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Date Taken", style: .default, handler: { [weak self] _ in
            self?.filter(by: .dateTaken)
        }))
        alert.addAction(UIAlertAction(title: "Date Published", style: .default, handler: { [weak self] _ in
            self?.filter(by: .datePublished)
        }))
        present(alert, animated: true)
    }

    private func filter(by sortType: PhotoSortType) {
        photoContainer = photoContainer?.sorted(by: sortType)
    }

    // MARK: Networking

    @objc private func fetchPhotos() {
        loadingIndicator.startAnimating()

        PhotoService.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoContainer):
                    self?.photoContainer = photoContainer
                case .failure(_):
                    self?.presentErrorAlert()
                }
                self?.collectionView?.refreshControl?.endRefreshing()
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
        cell.delegate = self

        return cell
    }

    // MARK:- UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = photoContainer?.items[indexPath.item]
            else { return }

        let svc = SFSafariViewController(url: photo.link)
        self.present(svc, animated: true, completion: nil)
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
