//
//  WatchlistRepository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/15.
//

import Foundation

protocol WatchlistRepositoryType {
    func getAllWatchlistItems() -> [WatchList]
}

class WatchlistRepository: WatchlistRepositoryType {

    private let coreDataManager: CoreDataManager

    // MARK: - Initialization
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    // MARK: - Function
    func getAllWatchlistItems() -> [WatchList] {
        coreDataManager.fetchAllWatchlistItems()
    }
}
