//
//  SearchMovieTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/17.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var nibCell: UIView!
    @IBOutlet weak var posterCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with imageURL: URL?, placeholderImage: UIImage?, title: String?) {
        if let imageURL = imageURL {
            posterCover?.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        } else {
            posterCover?.image = placeholderImage
        }
        titleLabel.text = title
    }

}
