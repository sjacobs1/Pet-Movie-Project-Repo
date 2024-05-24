//
//  NowPlayingModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]?
}

struct Movie: Codable {
    let movieID: Int?
    let originalTitle: String?
    let moviePoster: String?

    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
    }
}
