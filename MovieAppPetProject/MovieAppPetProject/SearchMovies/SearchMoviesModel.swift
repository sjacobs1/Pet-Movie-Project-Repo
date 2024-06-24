//
//  SearchMoviesModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

struct SearchMovies: Codable {
    let results: [SearchMoviesResults]?
}

struct SearchMoviesResults: Codable {
    let movieID: Int?
    let originalTitle: String?
    let moviePoster: String?
    let voteAverage: Double?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
