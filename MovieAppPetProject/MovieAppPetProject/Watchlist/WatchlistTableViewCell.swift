//
//  WatchlistTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/16.
//

import UIKit

class WatchlistTableViewCell: UITableViewCell {

    private lazy var watchlistViewModel = WatchlistViewModel(watchlistRepository: WatchlistRepository(coreDataManager: CoreDataManager()))
    private var watchlistItem: WatchList?

    // MARK: - IBOutlets
    @IBOutlet private weak var savedMovieTitle: UILabel!
    @IBAction private func removeFromWatchlistTapped(_ sender: UIButton) {
        guard let item = watchlistItem else { return }
        watchlistViewModel.deleteItem(item: item)
    }

    // MARK: - Function
    func configure(with title: String?, item: WatchList) {
        savedMovieTitle.text = title
        watchlistItem = item
    }
}
