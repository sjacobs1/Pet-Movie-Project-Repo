//
//  NetworkManager.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

enum CustomError: Error {
    case internalError
    case invalidUrl
    case invalidData
    case parsingError
}

class NetworkManager {
    func request<Generic: Codable>(path: URL?,
                                   model: Generic.Type,
                                   completion: @escaping (Result<Generic, CustomError>) -> Void) {
        guard let url = path else {
            completion(.failure(.invalidUrl))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(.internalError))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let object = try JSONDecoder().decode(Generic.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
