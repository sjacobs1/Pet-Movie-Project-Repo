//
//  NowPlaying-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

class NowPlayingViewModel {
    private let nowPlayingRepository = NowPlayingRepository()
    
    func fetchMovies() {
        nowPlayingRepository.fetchMovies { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
