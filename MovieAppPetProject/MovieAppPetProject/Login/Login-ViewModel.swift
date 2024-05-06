//
//  Login-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/05.
//

// LoginViewModel.swift
import Foundation

class LoginViewModel {

    // MARK: - Variables
    private let username = "Admin"
    private let password = "DVTPassword"

    // MARK: - Function
    func login(username: String?, password: String?, completion: @escaping (Bool) -> Void) {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
            completion(false)
            return
        }

        let isValidCredentials = username == self.username && password == self.password
        completion(isValidCredentials)
    }
}
