//
//  CoreDataManager.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import UIKit
import CoreData

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

    func createItem(movieDetails: MovieDetails, completion: @escaping (Error?) -> Void) {
        guard let context = context else {
            completion(CoreDataError.noContext)
            return
        }

        let newItem = WatchList(context: context)
        newItem.originalTitle = movieDetails.originalTitle

        if let posterPath = movieDetails.moviePoster,
           let posterURL = URL(string: "\(Constants.Path.moviePosterPath)\(posterPath)") {
            URLSession.shared.dataTask(with: posterURL) { data, response, error in
                if let error = error {
//                    DispatchQueue.main.async {
//                        completion(error)
//                    }
                    return
                }

                if let data = data {
                    newItem.moviePoster = data
                }

                do {
                    try context.save()
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            }.resume()
        } else {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
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

// MARK: - CoreDataManager Extension
extension CoreDataManager {
    func isMovieSaved(movieTitle: String) -> Bool {
        do {
            guard let context = context else { throw CoreDataError.noContext }
            let fetchRequest: NSFetchRequest<WatchList> = WatchList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "originalTitle == %@", movieTitle)
            let items = try context.fetch(fetchRequest)
            return !items.isEmpty
        } catch {
            return false
        }
    }
}
