//
//  GetMovieDetails-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

class MovieDetailsViewModel {

    // MARK: - Variables
    private let movieDetailsRepository: MovieDetailsRepositoryType
    private var movieID = 0
    var movieDetails: MovieDetails? {
        didSet {
            didUpdateDetails?()
        }
    }

    // MARK: - Computed properties
    var originalTitle: String? {
        movieDetails?.originalTitle
    }

    var overview: String? {
        movieDetails?.overview
    }

    var releaseDate: String? {
        movieDetails?.releaseDate
    }

    var runTime: Int? {
        movieDetails?.runtime
    }

    var moviePosterURL: URL? {
        movieDetails.flatMap { URL(string: "\(Constants.Path.moviePosterPath)\($0.moviePoster ?? "")") }
    }

    var voteAverage: Double? {
        movieDetails?.voteAverage
    }

    var status: String? {
        movieDetails?.status
    }

    // MARK: - Closure
    var didUpdateDetails: (() -> Void)?

    // MARK: - Initializer
    init(movieDetailsRepository: MovieDetailsRepositoryType) {
        self.movieDetailsRepository = movieDetailsRepository
    }

    // MARK: - Functions
    func fetchMovieDetails() {
        movieDetailsRepository.fetchMovieDetails(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let details):
                self?.movieDetails = details
            case .failure(let error):
                print(error)
            }
        }
    }

    func updateMovieID(movieID: Int) {
        self.movieID = movieID
        fetchMovieDetails()
    }

    func addToWatchlist() {
        guard let movieDetails = movieDetails else { return }
        movieDetailsRepository.addToWatchlist(movieDetails: movieDetails)
    }
}
