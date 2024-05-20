//
//  PopularMoviesViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

protocol PopularMoviesViewModelDelegate: AnyObject {
    func reloadView()
}

class PopularMoviesViewModel {

    // MARK: - Variables
    var popularMovies: [PopularMovieResults]?
    private let popularMoviesRepository: PopularMoviesRepositoryType?
    private weak var delegate: PopularMoviesViewModelDelegate?

    // MARK: - Initializer
    init(popularMoviesRepository: PopularMoviesRepositoryType?, delegate: PopularMoviesViewModelDelegate) {
        self.popularMovies = []
        self.popularMoviesRepository = popularMoviesRepository
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchMovies() {
        popularMoviesRepository?.fetchMovies { [weak self] result in
            switch result {
            case .success(let popularMovies):
                self?.popularMovies = popularMovies.results ?? []
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
