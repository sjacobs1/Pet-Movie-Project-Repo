//
//  Constants.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

struct Constants {
    struct URLs {
        static let apiKey = "2052300af48a4e777e1eaac356ed0aae"
        static let nowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        static let movieDetailsURL = "https://api.themoviedb.org/3/movie/823464?api_key=\(apiKey)"  
        static let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        static let topRatedMoviesURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)"
        static let upcomingMoviesURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
        static let searchMoviesURL = "https://api.themoviedb.org/3/search/movie?query=fight%20club&include_adult=false&api_key=\(apiKey)"
    }
}
