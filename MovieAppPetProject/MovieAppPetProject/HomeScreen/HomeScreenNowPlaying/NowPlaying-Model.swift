//
//  NowPlaying-Model.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

struct NowPlaying: Codable {
    let results: [NowPlayingResults]?
}

struct NowPlayingResults: Codable {
    let movieID: Int?
    let originalTitle: String?
    let moviePoster: String?

    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
    }
}
