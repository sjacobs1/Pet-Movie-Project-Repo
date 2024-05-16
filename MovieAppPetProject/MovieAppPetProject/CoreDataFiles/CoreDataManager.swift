//
//  CoreDataManager.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import UIKit

// MARK: - Enum
enum CoreDataError: Error {
    case noContext
}

// MARK: - CoreData Class
class CoreDataManager {
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Functions
    func fetchAllWatchlistItems() -> [WatchList] {
        do {
            guard let context = context else { throw CoreDataError.noContext }
            return try context.fetch(WatchList.fetchRequest())
        } catch {
            print("Error fetching watchlist items: \(error)")
            return []
        }
    }

    func createItem(movieDetails: MovieDetails) {
        do {
            guard let context = context else { throw CoreDataError.noContext }
            let newItem = WatchList(context: context)
            newItem.originalTitle = movieDetails.originalTitle
            newItem.moviePoster = movieDetails.moviePoster
            try context.save()
        } catch {
            print("Error creating item: \(error)")
        }
    }

    func deleteItem(item: WatchList) {
        guard let context = context else { return }
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Error deleting item: \(error)")
        }
    }
}
