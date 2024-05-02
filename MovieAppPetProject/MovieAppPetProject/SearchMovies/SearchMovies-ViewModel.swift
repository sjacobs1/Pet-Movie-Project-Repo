//
//  SearchMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
}

class SearchMoviesViewModel {

    private let searchMoviesRepository: SearchMoviesRepositoryType?
    var searchedMovies: [SearchMoviesResults]?
    private weak var delegate: ViewModelDelegate?

    init(searchMoviesRepository: SearchMoviesRepositoryType, delegate: ViewModelDelegate) {
        self.searchedMovies = []
        self.searchMoviesRepository = searchMoviesRepository
        self.delegate = delegate
    }

    var searchMoviesCount: Int {
        searchedMovies?.count ?? 0
    }

    func fetchSearchedMovies() {
        searchMoviesRepository?.fetchSearchedMovies { [weak self] result in
            switch result {
            case .success(let searchedMovie):
                self?.searchedMovies = searchedMovie.results ?? []
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
