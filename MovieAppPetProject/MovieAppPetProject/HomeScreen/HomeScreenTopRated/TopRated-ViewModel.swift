//
//  TopRated-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

class TopRatedViewModel {
    private let topRatedMoviesRepository = TopRatedMoviesRepository()
    
    var topRatedMovies: [TopRatedMoviesResults] = []
    
    func fetchMovies(completion: @escaping (Result<Void, CustomError>) -> Void) {
        topRatedMoviesRepository.fetchMovies { [weak self] result in
            switch result {
            case .success(let topRatedMovies):
                self?.topRatedMovies = topRatedMovies.results ?? []
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
