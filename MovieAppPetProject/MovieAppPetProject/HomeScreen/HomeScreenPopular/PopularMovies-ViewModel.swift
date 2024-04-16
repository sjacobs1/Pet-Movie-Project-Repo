//
//  PopularMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

class PopularMoviesViewModel {
    private let popularMoviesRepository = PopularMoviesRepository()
    
    var popularMovies: [PopularMovieResults] = []
    
    func fetchMovies(completion: @escaping (Result<Void, CustomError>) -> Void) {
        popularMoviesRepository.fetchMovies { [weak self] result in
            switch result {
            case .success(let popularMovies):
                self?.popularMovies = popularMovies.results ?? []
                completion(.success(()))
            case .failure(let error):
                print(error)
            }
        }
    }
}

