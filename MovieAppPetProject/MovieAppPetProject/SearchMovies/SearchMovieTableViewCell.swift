//
//  SearchMovieTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/17.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var nibCell: UIView!
    @IBOutlet private weak var posterCover: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Variable
    private lazy var imageLoader = APIImageLoader()

    // MARK: - Function
    func configure(with imageURL: URL?, placeholderImage: UIImage?, title: String?) {
        if let imageURL = imageURL {
            imageLoader.loadImage(from: imageURL, imageView: posterCover)
        } else {
            posterCover?.image = placeholderImage
        }
        titleLabel.text = title
    }

}
