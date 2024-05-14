//
//  CoreDataManager.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import Foundation
import UIKit

// MARK: - Enum
enum CoreDataError: Error {
    case noContext
}

// MARK: - CoreData Class
class CoreDataManager {
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Functions
    func getAllWatchlistItems() -> [WatchList] {
        do {
            guard let context = context else {
                throw CoreDataError.noContext
            }
            return try context.fetch(WatchList.fetchRequest())
        } catch {
            print("Error fetching watchlist items: \(error)")
            return []
        }
    }

    func createItem(movieDetails: MovieDetails) {
        do {
            guard let context = context else {
                throw CoreDataError.noContext
            }

            let newItem = WatchList(context: context)
            newItem.originalTitle = movieDetails.originalTitle
            try context.save()
        } catch {
            print("Error creating item: \(error)")
        }
    }
}
