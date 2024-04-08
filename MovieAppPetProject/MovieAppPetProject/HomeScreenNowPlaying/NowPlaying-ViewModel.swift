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
            case .success(let nowPlaying):
                if let movies = nowPlaying.results {
                    for movie in movies {
                        print("Movie ID: \(movie.movieID ?? 0 )")
                        print("Title: \(movie.originalTitle ?? "nil")")
                        print("Image: \(movie.moviePoster ?? "nil")\n")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
