//
//  GetMovieDetails-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

protocol MovieDetailsRepositoryType {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, CustomError>) -> Void)
}

class MovieDetailsRepository: MovieDetailsRepositoryType {

    // MARK: - Variable
    private let networkManager = NetworkManager()

    // MARK: - Function
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, CustomError>) -> Void) {
        let movieDetailsURL = Constants.URLs.movieDetailsURL(movieID: movieID)
        guard let apiUrl = URL(string: movieDetailsURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: MovieDetails.self) { result in
            completion(result)
        }
    }
}
