//
//  PosterCellCollectionViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/11.
//

import UIKit

class PosterCellCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterCover: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Variable
    private var imageLoader = APIImageLoader()

    // MARK: - Function
    func configure(with imageURL: URL?, placeholderImage: UIImage?, title: String?) {
        if let imageURL {
            imageLoader.loadImage(from: imageURL, imageView: posterCover)
        } else {
            posterCover.image = placeholderImage
        }
        titleLabel.text = title
    }
}
