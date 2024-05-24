////
////  PopularMoviesRepository.swift
////  MovieAppPetProject
////
////  Created by Sebastian Jacobs on 2024/04/09.
////
//
//import Foundation
//
//protocol PopularMoviesRepositoryType {
//    func fetchMovies(completion: @escaping (Result<PopularMovies, CustomError>) -> Void)
//}
//
//class PopularMoviesRepository: PopularMoviesRepositoryType {
//
//    // MARK: - Variable
//    private let networkManager = NetworkManager()
//
//    // MARK: - Function
//    func fetchMovies(completion: @escaping (Result<PopularMovies, CustomError>) -> Void) {
//        guard let apiUrl = URL(string: Constants.URLs.popularMoviesURL) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//
//        networkManager.request(path: apiUrl, model: PopularMovies.self) { result in
//            completion(result)
//        }
//    }
//}
