//
//  UpcomingMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

class UpcomingMoviesViewModel {
    private let upcomingMoviesRepository = UpcomingMoviesRepository()
    
    var upcomingMovies: [UpcomingMoviesResults] = []
    
    func fetchMovies(completion: @escaping (Result<Void, CustomError>) -> Void) {
        upcomingMoviesRepository.fetchMovies { [weak self] result in
            switch result {
            case .success(let upcomingMovies):
                self?.upcomingMovies = upcomingMovies.results ?? []
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

