//
//  GetMovieDetails-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

typealias MovieDetailsCompletion = (Result<MovieDetails, CustomError>) -> Void

protocol MovieDetailsRepositoryType {
    func fetchMovieDetails(movieID: Int, completion: @escaping MovieDetailsCompletion)
    func addToWatchlist(movieDetails: MovieDetails)
    func isMovieSaved(movieTitle: String) -> Bool
}

class MovieDetailsRepository: MovieDetailsRepositoryType {

    // MARK: - Variable
    private let networkManager: NetworkManager
    private let coreDataManager: CoreDataManager

    // MARK: - Initializer
    init(coreDataManager: CoreDataManager, networkManager: NetworkManager) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }

    // MARK: - Function
    func fetchMovieDetails(movieID: Int, completion: @escaping MovieDetailsCompletion) {
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

// MARK: - MovieDetailsRespository Extension
extension MovieDetailsRepository {
    func isMovieSaved(movieTitle: String) -> Bool {
        coreDataManager.isMovieSaved(movieTitle: movieTitle)
    }
}
