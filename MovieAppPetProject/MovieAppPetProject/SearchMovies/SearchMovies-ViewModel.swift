//
//  SearchMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import Foundation

class SearchMoviesViewModel {
    private let searchMoviesRepository = SearchMoviesRepository()
    
    func fetchSearchedMovies() {
        searchMoviesRepository.fetchSearchedMovies { result in
            switch result {
            case .success(let searchedMovie):
                if let movies = searchedMovie.results {
                    print("Search Results:")
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
