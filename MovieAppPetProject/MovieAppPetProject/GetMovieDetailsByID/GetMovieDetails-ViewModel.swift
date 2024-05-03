//
//  GetMovieDetails-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

class MovieDetailsViewModel {

    // MARK: - Variables
    var movieDetails: MovieDetails?
    typealias MovieDetailsCompletion = (Result<MovieDetails, CustomError>) -> Void
    private var selectedSearchMovie: SearchMoviesResults?
    private var selectedHomeScreenMovies: NowPlayingResults?
    private let movieDetailsRepository: MovieDetailsRepositoryType?

    // MARK: - Initializer
    init(movieDetails: MovieDetails?, selectedSearchMovie: SearchMoviesResults?, selectedHomeScreenMovies: NowPlayingResults?, movieDetailsRepository: MovieDetailsRepositoryType) {
        self.movieDetails = movieDetails
        self.selectedSearchMovie = selectedSearchMovie
        self.selectedHomeScreenMovies = selectedHomeScreenMovies
        self.movieDetailsRepository = movieDetailsRepository
    }

    // MARK: - Functions
    func setMovieDetails(selectedSearchMovie: SearchMoviesResults?, selectedHomeScreenMovies: NowPlayingResults?) {
        self.selectedSearchMovie = selectedSearchMovie
        self.selectedHomeScreenMovies = selectedHomeScreenMovies
    }

    func displayMovieDetails(completion: @escaping (String?, URL?) -> Void) {
        if let nowPlayingMovie = selectedHomeScreenMovies {
            let title = nowPlayingMovie.originalTitle
            if let posterPath = nowPlayingMovie.moviePoster {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                completion(title, posterURL)
            } else {
                completion(title, nil)
            }
        } else if let searchMovie = selectedSearchMovie {
            let title = searchMovie.originalTitle
            if let posterPath = searchMovie.moviePoster {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                completion(title, posterURL)
            } else {
                completion(title, nil)
            }
        }
    }

    func fetchMovieDetails(completion: @escaping MovieDetailsCompletion) {
        movieDetailsRepository?.fetchMovieDetails { result in
            switch result {
            case .success(let details):
                self.movieDetails = details
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
