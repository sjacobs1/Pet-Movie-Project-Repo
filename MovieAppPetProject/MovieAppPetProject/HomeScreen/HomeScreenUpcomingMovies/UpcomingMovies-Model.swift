//
//  UpcomingMovies-Model.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

protocol MovieData {
    var movieID: Int? { get }
    var originalTitle: String? { get }
    var moviePoster: String? { get }
}

struct UpcomingMovies: Codable {
    let results: [UpcomingMoviesResults]?
}

struct UpcomingMoviesResults: Codable, MovieData {
    let movieID: Int?
    let originalTitle: String?
    let moviePoster: String?
    
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
    }
}
