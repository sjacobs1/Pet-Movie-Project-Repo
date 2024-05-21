//
//  NowPlayingRepository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

protocol NowPlayingRepositoryType {
    func fetchMovies(completion: @escaping (Result<NowPlaying, CustomError>) -> Void)
}

class NowPlayingRepository: NowPlayingRepositoryType {

    // MARK: - Variable
    private let networkManager = NetworkManager()

    // MARK: - Function
    func fetchMovies(completion: @escaping (Result<NowPlaying, CustomError>) -> Void) {
        guard let apiUrl = URL(string: Constants.URLs.nowPlayingURL) else {
            completion(.failure(.invalidUrl))
            return
        }

        networkManager.request(path: apiUrl, model: NowPlaying.self) { result in
            completion(result)
        }
    }
}
