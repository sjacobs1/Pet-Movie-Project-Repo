//
//  SearchMoviesRepository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

typealias SearchMoviesCompletion = (Result<SearchMovies, CustomError>) -> Void

protocol SearchMoviesRepositoryType {
    func fetchSearchedMovies(query: String, completion: @escaping SearchMoviesCompletion)
}

class SearchMoviesRepository: SearchMoviesRepositoryType {
    private let networkManager = NetworkManager()

    func fetchSearchedMovies(query: String, completion: @escaping SearchMoviesCompletion) {
        let urlString = Constants.URLs.searchMoviesURL(query: query)
        
        guard let apiUrl = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: SearchMovies.self) { result in
            completion(result)
        }
    }
}
