//
//  UpcomingMovies-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

class UpcomingMoviesRepository {
    private let networkManager = NetworkManager()

    func fetchMovies(completion: @escaping (Result<UpcomingMovies, CustomError>) -> Void) {
        guard let apiUrl = URL(string: Constants.URLs.upcomingMoviesURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: UpcomingMovies.self) { result in
            completion(result)
        }
    }
}
