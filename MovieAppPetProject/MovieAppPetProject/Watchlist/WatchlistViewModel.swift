//
//  WatchlistViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import Foundation

class WatchlistViewModel {

    // MARK: - Variable
    private let watchlistRepository: WatchlistRepositoryType

    // MARK: - Computed Variable
    var savedMoviesCount: Int {
        watchlistRepository.getAllWatchlistItems().count
    }

    // MARK: - Initializer
    init(watchlistRepository: WatchlistRepositoryType) {
        self.watchlistRepository = watchlistRepository
    }

    // MARK: - Function
    func fetchAndDisplayWatchlistItems() -> [WatchList] {
        watchlistRepository.getAllWatchlistItems()
    }

    func deleteItem(item: WatchList) {
        watchlistRepository.deleteItem(item: item)
    }
}
