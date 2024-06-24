//
//  SearchMoviesViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

protocol ViewModelType: AnyObject {
    func reloadView()
    func showNoResultsMessage()
    func hideNoResultsMessage()
    func startLoadingIndicator()
    func stopLoadingIndicator()
    func displayError(with message: String)
}

class SearchMoviesViewModel {

    // MARK: - Variables
    private let searchMoviesRepository: SearchMoviesRepositoryType?
    private var searchedMovies: [SearchMoviesResults]?
    private weak var delegate: ViewModelType?

    // MARK: - Computed Variable
    var searchMoviesCount: Int {
        searchedMovies?.count ?? 0
    }

    // MARK: - Initializer
    init(searchMoviesRepository: SearchMoviesRepositoryType, delegate: ViewModelType) {
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

    func fetchSearchedMovies(with query: String) {
        delegate?.startLoadingIndicator()
        searchMoviesRepository?.fetchSearchedMovies(query: query) { [weak self] result in
            switch result {
            case .success(let searchedMovie):
                self?.searchedMovies = searchedMovie.results ?? []
                if self?.searchedMovies?.isEmpty ?? true {
                    self?.delegate?.showNoResultsMessage()
                } else {
                    self?.delegate?.hideNoResultsMessage()
                }
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.displayError(with: error.localizedDescription)
            }
            self?.delegate?.stopLoadingIndicator()
        }
    }

    func clearSearchResults() {
        searchedMovies = []
        delegate?.reloadView()
        delegate?.showNoResultsMessage()
    }
}
