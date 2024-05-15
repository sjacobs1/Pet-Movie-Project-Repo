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

    // MARK: - Initializer
    init(watchlistRepository: WatchlistRepositoryType) {
        self.watchlistRepository = watchlistRepository
    }

    // MARK: - Function
    func fetchAndDisplayWatchlistItems() -> [WatchList] {
        watchlistRepository.getAllWatchlistItems()
    }
}
