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
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!

    // MARK: - Variable
    private var imageLoader = APIImageLoader()

    // MARK: - Function
    func configure(with imageURL: URL?, placeholderImage: UIImage?, title: String?, voteAverage: String, releaseDate: String) {
        if let imageURL = imageURL {
            imageLoader.loadImage(from: imageURL, imageView: posterCover)
        }
        titleLabel?.text = title
        voteAverageLabel?.text = voteAverage
        releaseDateLabel?.text = releaseDate
    }
}
