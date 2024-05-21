//
//  TopRatedRepository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

protocol TopRatedMoviesRepositoryType {
    func fetchMovies(completion: @escaping (Result<TopRatedMovies, CustomError>) -> Void)
}

class TopRatedMoviesRepository: TopRatedMoviesRepositoryType {

    // MARK: - Variable
    private let networkManager = NetworkManager()

    // MARK: - Function
    func fetchMovies(completion: @escaping (Result<TopRatedMovies, CustomError>) -> Void) {
        guard let apiUrl = URL(string: Constants.URLs.topRatedMoviesURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: TopRatedMovies.self) { result in
            completion(result)
        }
    }
}
