//
//  WatchlistTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/16.
//

import UIKit

protocol WatchlistTableViewCellType: AnyObject {
    func didRemoveItem(item: WatchList)
}

class WatchlistTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var savedMovieTitle: UILabel!
    @IBOutlet private weak var savedMoviePoster: UIImageView!

    // MARK: - IBAction
    @IBAction private func removeFromWatchlistTapped(_ sender: UIButton) {
        guard let item = watchlistItem else { return }
        delegate?.didRemoveItem(item: item)
    }

    // MARK: - Variables
    weak var delegate: WatchlistTableViewCellType?
    private var watchlistItem: WatchList?

    // MARK: - Function
    func configure(with title: String?, item: WatchList) {
        savedMovieTitle.text = title
        watchlistItem = item
        if let posterData = item.moviePoster {
            savedMoviePoster.image = UIImage(data: posterData)
        } else {
            savedMoviePoster.image = nil
        }
    }
}
