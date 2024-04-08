//
//  GetMovieDetails-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

class MovieDetailsViewModel {
    private let movieDetailsRepository = MovieDetailsRepository()
    
    func fetchMovieDetails() {
        movieDetailsRepository.fetchMovieDetails { result in
            switch result {
            case .success(let movieDetails):
                print("Movie Details:")
                print("Title: \(movieDetails.originalTitle ?? "N/A")")
                print("Image: \(movieDetails.moviePoster ?? "N/A")")
                print("Overview: \(movieDetails.overview ?? "N/A")")
                print("Release Date: \(movieDetails.releaseDate ?? "N/A")")
                print("Runtime: \(movieDetails.runtime ?? 0)")
                print("Release Status: \(movieDetails.status ?? "N/A")")
                print("Vote: \(movieDetails.voteAverage ?? 0.0)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
