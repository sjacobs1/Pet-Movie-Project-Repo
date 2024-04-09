//
//  UpcomingMovies-Model.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

struct UpcomingMovies: Codable {
    let results: [UpcomingMoviesResults]?
}

struct UpcomingMoviesResults: Codable {
    let movieID: Int?
    let originalTitle: String?
    let moviePoster: String?
    
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
    }
}
