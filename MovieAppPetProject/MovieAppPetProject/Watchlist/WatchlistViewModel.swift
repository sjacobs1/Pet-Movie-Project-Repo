//
//  WatchlistViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import Foundation

protocol WatchlistViewModelType: AnyObject {
    func updateWatchlist()
}

class WatchlistViewModel {

    // MARK: - Variable
    var watchlistItems: [WatchList] = []
    weak var delegate: WatchlistViewModelType?
    private let watchlistRepository: WatchlistRepositoryType

    // MARK: - Computed Variable
    var savedMoviesCount: Int {
        watchlistItems.count
    }

    // MARK: - Initializer
    init(watchlistRepository: WatchlistRepositoryType, delegate: WatchlistViewModelType) {
        self.watchlistRepository = watchlistRepository
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchAndDisplayWatchlistItems() {
        watchlistItems = watchlistRepository.fetchAllWatchlistItems()
        delegate?.updateWatchlist()
    }

    func deleteItem(item: WatchList) {
        watchlistRepository.deleteItem(item: item)
        fetchAndDisplayWatchlistItems()
    }
}
