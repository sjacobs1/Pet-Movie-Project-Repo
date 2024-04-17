//
//  SearchMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

class SearchMoviesViewModel {
    private let searchMoviesRepository = SearchMoviesRepository()
    
    var searchedMovies: [SearchMoviesResults] = []
    
    func fetchSearchedMovies(completion: @escaping (Result<Void, CustomError>) -> Void) {
        searchMoviesRepository.fetchSearchedMovies { [weak self] result in
            switch result {
            case .success(let searchedMovie):
                self?.searchedMovies = searchedMovie.results ?? []
                completion(.success(()))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
