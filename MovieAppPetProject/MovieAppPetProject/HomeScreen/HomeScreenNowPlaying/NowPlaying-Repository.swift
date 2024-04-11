//
//  NowPlaying-Repository.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

//class NowPlayingRepository {
//    private let networkManager = NetworkManager()
//
//    func fetchMovies(completion: @escaping (Result<NowPlaying, CustomError>) -> Void) {
//        guard let apiUrl = URL(string: Constants.URLs.nowPlayingURL) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//
//        networkManager.request(path: apiUrl, model: NowPlaying.self) { result in
//            completion(result)
//        }
//    }
//}
class NowPlayingRepository {
    private let networkManager = NetworkManager()

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
