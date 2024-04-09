//
//  TopRated-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

class TopRatedMoviesRepository {
    private let networkManager = NetworkManager()

    func fetchMovies(completion: @escaping (Result<TopRatedMovies, CustomError>) -> Void) {
        guard let apiUrl = URL(string: Constants.URLs.popularMoviesURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: TopRatedMovies.self) { result in
            completion(result)
        }
    }
}
