//
//  GetMovieDetails-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

protocol MovieDetailsRepositoryType {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, CustomError>) -> Void)
    func addToWatchlist(movieDetails: MovieDetails)
}

class MovieDetailsRepository: MovieDetailsRepositoryType {

    // MARK: - Variable
    private let networkManager = NetworkManager()
    private let coreDataManager: CoreDataManager

    // MARK: - Initializer
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

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

    func addToWatchlist(movieDetails: MovieDetails) {
        coreDataManager.createItem(movieDetails: movieDetails)
    }
}
