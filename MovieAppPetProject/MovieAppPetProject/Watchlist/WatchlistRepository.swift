//
//  WatchlistRepository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/15.
//

import Foundation

protocol WatchlistRepositoryType {
    func fetchAllWatchlistItems() -> [WatchList]
    func deleteItem(item: WatchList)
}

class WatchlistRepository: WatchlistRepositoryType {

    private let coreDataManager: CoreDataManager

    // MARK: - Initialization
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    // MARK: - Function
    func fetchAllWatchlistItems() -> [WatchList] {
        coreDataManager.fetchAllWatchlistItems()
    }

    func deleteItem(item: WatchList) {
        coreDataManager.deleteItem(item: item)
    }
}
