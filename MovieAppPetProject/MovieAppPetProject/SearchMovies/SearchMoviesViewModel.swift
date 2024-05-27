//
//  SearchMoviesViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
}

class SearchMoviesViewModel {

    // MARK: - Variables
    private let searchMoviesRepository: SearchMoviesRepositoryType?
    private var searchedMovies: [SearchMoviesResults]?
    private weak var delegate: ViewModelDelegate?

    // MARK: - Computed Variable
    var searchMoviesCount: Int {
        searchedMovies?.count ?? 0
    }

    // MARK: - Initializer
    init(searchMoviesRepository: SearchMoviesRepositoryType, delegate: ViewModelDelegate) {
        self.searchedMovies = []
        self.searchMoviesRepository = searchMoviesRepository
        self.delegate = delegate
    }

    // MARK: - Functions
    func movie(at index: Int) -> SearchMoviesResults? {
        guard index >= 0 && index < searchedMovies?.count ?? 0 else {
            return nil
        }
        return searchedMovies?[index]
    }

    func formattedVoteAverage(for movie: SearchMoviesResults?) -> String {
        if let voteAverage = movie?.voteAverage {
            return String(format: "Rating: %.1f/10", voteAverage)
        } else {
            return "Rating: N/A"
        }
    }

    func formattedReleaseDate(for movie: SearchMoviesResults?) -> String {
        if let releaseDate = movie?.releaseDate, releaseDate.count >= 4 {
            return "Release year: \(releaseDate.prefix(4))"
        } else {
            return "Release year: N/A"
        }
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
