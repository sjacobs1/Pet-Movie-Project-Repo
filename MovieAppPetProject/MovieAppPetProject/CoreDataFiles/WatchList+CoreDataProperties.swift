//
//  WatchList+CoreDataProperties.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//
//

import Foundation
import CoreData

extension WatchList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchList> {
        return NSFetchRequest<WatchList>(entityName: "WatchList")
    }

    @NSManaged public var originalTitle: String?
}

extension WatchList: Identifiable {
}
