//
//  WatchlistViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import Foundation

protocol WatchlistViewModelType: AnyObject {
    func didUpdateWatchlist()
}

class WatchlistViewModel {

    // MARK: - Variable
    var watchlistItems: [WatchList] = []
    weak var delegate: WatchlistViewModelType?
    private let watchlistRepository: WatchlistRepositoryType

    // MARK: - Computed Variable
    var savedMoviesCount: Int {
        watchlistRepository.getAllWatchlistItems().count
    }

    // MARK: - Initializer
    init(watchlistRepository: WatchlistRepositoryType, delegate: WatchlistViewModelType) {
        self.watchlistRepository = watchlistRepository
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchAndDisplayWatchlistItems() {
        watchlistItems = watchlistRepository.getAllWatchlistItems()
        delegate?.didUpdateWatchlist()
    }

    func deleteItem(item: WatchList) {
        watchlistRepository.deleteItem(item: item)
        fetchAndDisplayWatchlistItems()
    }
}
