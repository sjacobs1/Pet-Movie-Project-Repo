//
//  SearchMovies-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

protocol SearchMoviesRepositoryType {
    func fetchSearchedMovies(completion: @escaping Result<SearchMovies, CustomError>)
}

class SearchMoviesRepository: SearchMoviesRepositoryType {
    private let networkManager = NetworkManager()

    func fetchSearchedMovies(completion: @escaping (Result<SearchMovies, CustomError>) -> Void) {
        guard let apiUrl = URL(string: Constants.URLs.searchMoviesURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: SearchMovies.self) { result in
            completion(result)
        }
    }
}
