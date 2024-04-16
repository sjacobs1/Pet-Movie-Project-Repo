//
//  NowPlaying-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

class NowPlayingViewModel {
    private let nowPlayingRepository = NowPlayingRepository()

    var nowPlayingMovies: [NowPlayingResults] = []

    func fetchNowPlayingMovies(completion: @escaping (Result<Void, CustomError>) -> Void) {
        nowPlayingRepository.fetchMovies { [weak self] result in
            switch result {
            case .success(let nowPlaying):
                self?.nowPlayingMovies = nowPlaying.results ?? []
                print("Now playing movies fetched successfully: \(self?.nowPlayingMovies ?? [])")
                completion(.success(()))
            case .failure(let error):
                print("Error fetching now playing movies: \(error)")
                completion(.failure(error))
            }
        }
    }
}
