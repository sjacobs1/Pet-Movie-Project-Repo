//
//  NowPlaying-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

//class NowPlayingViewModel {
//    private let nowPlayingRepository = NowPlayingRepository()
//    
//    func fetchMovies(completion: @escaping (Result<NowPlaying, CustomError>) -> Void) {
//        nowPlayingRepository.fetchMovies(completion: completion)
//    }
//}
class NowPlayingViewModel {
    private let nowPlayingRepository = NowPlayingRepository()
    
    var nowPlayingMovies: [NowPlayingResults] = []

    func fetchNowPlayingMovies(completion: @escaping (Result<Void, CustomError>) -> Void) {
        nowPlayingRepository.fetchMovies { [weak self] result in
            switch result {
            case .success(let nowPlaying):
                self?.nowPlayingMovies = nowPlaying.results ?? []
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
