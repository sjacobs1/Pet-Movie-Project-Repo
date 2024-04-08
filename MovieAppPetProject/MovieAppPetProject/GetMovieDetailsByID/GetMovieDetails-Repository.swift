//
//  GetMovieDetails-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

class MovieDetailsRepository {
    private let networkManager = NetworkManager()

    func fetchMovieDetails(completion: @escaping (Result<MovieDetails, CustomError>) -> Void) {
        guard let apiUrl = URL(string: Constants.URLs.movieDetailsURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: MovieDetails.self) { result in
            completion(result)
        }
    }
}
