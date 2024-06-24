//
//  MovieViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

// MARK: - Protocol
protocol MovieViewModelType: AnyObject {
    func reloadView()
    func startLoadingIndicator()
    func stopLoadingIndicator()
    func handleFetchError(_ error: Error)
}

class MovieViewModel {

    // MARK: - Variables
    private var nowPlayingMoviesList: [Movie] = []
    private var popularMoviesList: [Movie] = []
    private var topRatedMoviesList: [Movie] = []
    private var upcomingMoviesList: [Movie] = []
    private let movieRepository: MovieRepositoryType
    private weak var delegate: MovieViewModelType?

    // MARK: - Computed Properties
    var nowPlayingMovies: [Movie] {
        nowPlayingMoviesList
    }

    var popularMovies: [Movie] {
        popularMoviesList
    }

    var topRatedMovies: [Movie] {
        topRatedMoviesList
    }

    var upcomingMovies: [Movie] {
        upcomingMoviesList
    }

    // MARK: - Initializer
    init(movieRepository: MovieRepositoryType, delegate: MovieViewModelType) {
        self.movieRepository = movieRepository
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchMovies(for category: MovieCategory) {
        delegate?.startLoadingIndicator()
        movieRepository.fetchMovies(for: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                let movies = movieResponse.results ?? []
                switch category {
                case .nowPlaying:
                    self.nowPlayingMoviesList = movies
                case .popular:
                    self.popularMoviesList = movies
                case .topRated:
                    self.topRatedMoviesList = movies
                case .upcoming:
                    self.upcomingMoviesList = movies
                }
                self.delegate?.reloadView()
            case .failure(let error):
                self.delegate?.handleFetchError(error)
            }
            self.delegate?.stopLoadingIndicator()
        }
    }
}
