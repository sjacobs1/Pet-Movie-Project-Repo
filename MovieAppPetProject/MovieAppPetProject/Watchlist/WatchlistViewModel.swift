//
//  WatchlistViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import Foundation

class WatchlistViewModel {

    // MARK: - Variable
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    // MARK: - Function
    func fetchAndDisplayWatchlistItems() -> [WatchList] {
        coreDataManager.getAllWatchlistItems()
    }
}
