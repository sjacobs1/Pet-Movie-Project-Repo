//
//  TopRated-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

protocol TopRatedMoviesViewModelDelegate: AnyObject {
    func reloadView()
}

class TopRatedViewModel {

    // MARK: - Variables
    var topRatedMovies: [TopRatedMoviesResults]?
    private let topRatedMoviesRepository: TopRatedMoviesRepositoryType?
    private weak var delegate: TopRatedMoviesViewModelDelegate?

    // MARK: - Initializer
    init(topRatedMoviesRepository: TopRatedMoviesRepositoryType?, delegate: TopRatedMoviesViewModelDelegate) {
        self.topRatedMovies = []
        self.topRatedMoviesRepository = topRatedMoviesRepository
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchMovies() {
        topRatedMoviesRepository?.fetchMovies { [weak self] result in
            switch result {
            case .success(let topRatedMovies):
                self?.topRatedMovies = topRatedMovies.results ?? []
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
