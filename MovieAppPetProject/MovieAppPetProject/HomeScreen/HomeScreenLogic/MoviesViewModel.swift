//
//  NowPlayingViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

// MARK: - Protocol
protocol MoviesViewModelType: AnyObject {
    func reloadView()
}

class MoviesViewModel {

    // MARK: - Variables
    var movies: [Movie]?
    private let moviesRepository: MoviesRepositoryType
    private weak var delegate: MoviesViewModelType?
    private var category: MovieCategory

    // MARK: - Initializer
    init(moviesRepository: MoviesRepositoryType, category: MovieCategory, delegate: MoviesViewModelType) {
        self.moviesRepository = moviesRepository
        self.category = category
        self.delegate = delegate
        self.movies = []
    }

    // MARK: - Function
    func fetchMovies() {
        moviesRepository.fetchMovies(for: category) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movies = movieResponse.results ?? []
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
