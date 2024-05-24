//
//  NowPlayingRepository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

// MARK: - Typealias
typealias FetchMoviesCompletion = (Result<MovieResponse, CustomError>) -> Void

// MARK: - Enum
enum MovieCategory {
    case nowPlaying
    case popular
    case upcoming
    case topRated

    var url: String {
        switch self {
        case .nowPlaying:
            return Constants.URLs.nowPlayingURL
        case .popular:
            return Constants.URLs.popularMoviesURL
        case .upcoming:
            return Constants.URLs.upcomingMoviesURL
        case .topRated:
            return Constants.URLs.topRatedMoviesURL
        }
    }
}

// MARK: - Protocol
protocol MoviesRepositoryType {
    func fetchMovies(for category: MovieCategory, completion: @escaping FetchMoviesCompletion)
}

class MoviesRepository: MoviesRepositoryType {

    // MARK: - Variable
    private let networkManager = NetworkManager()

    // MARK: - Function
    func fetchMovies(for category: MovieCategory, completion: @escaping FetchMoviesCompletion) {
        guard let apiUrl = URL(string: category.url) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: MovieResponse.self) { result in
            completion(result)
        }
    }
}
