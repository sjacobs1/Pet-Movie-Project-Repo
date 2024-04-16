//
//  PosterCellCollectionViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/11.
//

import UIKit

class PosterCellCollectionViewCell: UICollectionViewCell {
    
    
  
    @IBOutlet weak var posterCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with imageURL: URL?, placeholderImage: UIImage?, title: String?) {
        if let imageURL = imageURL {
            posterCover?.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        } else {
            posterCover.image = placeholderImage
        }
        titleLabel.text = title
        
    }
    
}
