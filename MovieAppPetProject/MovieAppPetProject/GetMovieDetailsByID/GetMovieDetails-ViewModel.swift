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
    private let movieID: Int
    var movieDetails: MovieDetails? {
        didSet {
            didUpdateDetails?()
        }
    }

    // MARK: - Computed properties
    func originalTitle() -> String? {
        movieDetails?.originalTitle
    }

    func overview() -> String? {
        movieDetails?.overview
    }

    func releaseDate() -> String? {
        movieDetails.map { "Release Date: \($0.releaseDate ?? "")" }
    }

    func moviePosterURL() -> URL? {
        movieDetails.flatMap { URL(string: "https://image.tmdb.org/t/p/w500\($0.moviePoster ?? "")") }
    }

    // MARK: - Closure
    var didUpdateDetails: (() -> Void)?

    // MARK: - Initializer
    init(movieID: Int, movieDetailsRepository: MovieDetailsRepositoryType) {
        self.movieID = movieID
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
}
