//
//  PopularMovies-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/09.
//

class PopularMoviesViewModel {
    private let popularMoviesRepository = PopularMoviesRepository()
    
    func fetchMovies() {
        popularMoviesRepository.fetchMovies { result in
            switch result {
            case .success(let nowPlaying):
                if let movies = nowPlaying.results {
                    for movie in movies {
                        print("Popular Movies:")
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
