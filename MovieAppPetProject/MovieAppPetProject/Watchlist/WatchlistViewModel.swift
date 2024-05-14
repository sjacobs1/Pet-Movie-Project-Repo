//
//  WatchlistViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import Foundation

class WatchlistViewModel {

    // MARK: - Variable
    private let coreDataManager = CoreDataManager()

    // MARK: - Function
    func fetchAndDisplayWatchlistItems() {
        let watchlistItems = coreDataManager.getAllWatchlistItems()
        for item in watchlistItems {
            print("Original Title: \(item.originalTitle ?? "N/A")")
        }
    }
}
