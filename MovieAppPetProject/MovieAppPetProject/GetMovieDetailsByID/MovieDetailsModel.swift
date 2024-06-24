//
//  MovieDetailsModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

struct MovieDetails: Codable {
    let originalTitle: String?
    let overview: String?
    let moviePoster: String?
    let releaseDate: String?
    let runtime: Int?
    let status: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case overview, runtime, status
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
