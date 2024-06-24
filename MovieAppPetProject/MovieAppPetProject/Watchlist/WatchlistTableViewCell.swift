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
    }
}
