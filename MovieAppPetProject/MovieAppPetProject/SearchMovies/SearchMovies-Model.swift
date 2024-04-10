//
//  SearchMovies-Model.swift
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
    
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case originalTitle = "original_title"
        case moviePoster = "poster_path"
    }
}
