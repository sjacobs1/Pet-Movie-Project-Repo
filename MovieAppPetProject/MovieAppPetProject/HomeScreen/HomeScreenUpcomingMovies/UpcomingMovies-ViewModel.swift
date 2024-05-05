//
//  UpcomingMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

import Foundation

protocol UpcomingMoviesViewModelDelegate: AnyObject {
    func reloadView()
}

class UpcomingMoviesViewModel {

    // MARK: - Variables
    var upcomingMovies: [UpcomingMoviesResults]?
    private let upcomingMoviesRepository: UpcomingMoviesRepositoryType?
    private weak var delegate: UpcomingMoviesViewModelDelegate?

    // MARK: - Initializer
    init(upcomingMoviesRepository: UpcomingMoviesRepositoryType?, delegate: UpcomingMoviesViewModelDelegate) {
        self.upcomingMovies = []
        self.upcomingMoviesRepository = upcomingMoviesRepository
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchMovies() {
        upcomingMoviesRepository?.fetchMovies { [weak self] result in
            switch result {
            case .success(let upcomingMovies):
                self?.upcomingMovies = upcomingMovies.results ?? []
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
