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
    case fetchError(Error)
    case createError(Error)
    case deleteError(Error)
}

var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support
func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - CoreData Class
class CoreDataManager {
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Functions
    func fetchAllWatchlistItems() throws -> [WatchList] {
        guard let context = context else { throw CoreDataError.noContext }
        do {
            return try context.fetch(WatchList.fetchRequest())
        } catch {
            throw CoreDataError.fetchError(error)
        }
    }

    func createItem(movieDetails: MovieDetails) throws {
        guard let context = context else { throw CoreDataError.noContext }
        do {
            let newItem = WatchList(context: context)
            newItem.originalTitle = movieDetails.originalTitle
            newItem.moviePoster = movieDetails.moviePoster
            saveContext()
        } catch {
            throw CoreDataError.createError(error)
        }
    }

    func deleteItem(item: WatchList) throws {
        guard let context = context else { throw CoreDataError.noContext }
        context.delete(item)
        do {
            saveContext()
        } catch {
            throw CoreDataError.deleteError(error)
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
