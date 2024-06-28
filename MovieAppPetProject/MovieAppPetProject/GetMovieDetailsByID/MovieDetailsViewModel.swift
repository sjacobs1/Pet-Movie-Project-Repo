//
//  MovieDetailsViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

protocol MovieDetailsViewModelType: AnyObject {
    func updateMovieDetailsUI()
    func displayError(with message: String)
}

class MovieDetailsViewModel {

    // MARK: - Variables
    var isMovieSaved = false
    var movieDetails: MovieDetails?
    weak var delegate: MovieDetailsViewModelType?
    private let movieDetailsRepository: MovieDetailsRepositoryType
    private var movieID = 0

    // MARK: - Computed properties
    var originalTitle: String? {
        movieDetails?.originalTitle
    }

    var overview: String? {
        movieDetails?.overview
    }

    var releaseDate: String? {
        guard let date = movieDetails?.releaseDate else { return nil }
        return String(date.prefix(4))
    }

    var runTime: Int? {
        movieDetails?.runtime
    }

    var moviePosterURL: URL? {
        guard let posterPath = movieDetails?.moviePoster, !posterPath.isEmpty else {
            return nil
        }
        return URL(string: "\(Constants.Path.moviePosterPath)\(posterPath)")
    }

    var voteAverage: Double? {
        movieDetails?.voteAverage
    }

    var status: String? {
        movieDetails?.status
    }

    // MARK: - Initializer
    init(movieDetailsRepository: MovieDetailsRepositoryType, delegate: MovieDetailsViewModelType?) {
        self.movieDetailsRepository = movieDetailsRepository
        self.delegate = delegate
    }

    // MARK: - Functions
    func fetchMovieDetails() {
        movieDetailsRepository.fetchMovieDetails(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let details):
                self?.movieDetails = details
                self?.isMovieSaved = self?.movieDetailsRepository.isMovieSaved(movieTitle: details.originalTitle ?? "") ?? false
                self?.delegate?.updateMovieDetailsUI()
            case .failure(let error):
                self?.delegate?.displayError(with: error.localizedDescription)
            }
        }
    }

    func updateMovieID(movieID: Int) {
        self.movieID = movieID
        fetchMovieDetails()
    }

    func addToWatchlist() {
        guard let movieDetails = movieDetails, let originalTitle = movieDetails.originalTitle else { return }
        if movieDetailsRepository.isMovieSaved(movieTitle: originalTitle) {
            delegate?.displayError(with: "Movie is already in the watchlist.")
        } else {
            movieDetailsRepository.addToWatchlist(movieDetails: movieDetails)
            isMovieSaved = true
            delegate?.updateMovieDetailsUI()
        }
    }
}
