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

    // MARK: - Function
    func configure(with imageURL: URL?, placeholderImage: UIImage?, title: String?) {
        if let imageURL = imageURL {
            posterCover?.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        } else {
            posterCover?.image = placeholderImage
        }
        titleLabel.text = title
    }

}
