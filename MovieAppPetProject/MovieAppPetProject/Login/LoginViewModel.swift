//
//  Login-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/05.
//

import Foundation

class LoginViewModel {

    // MARK: - Variables
    private let username = "Admin"
    private let password = "DVTPassword"

    // MARK: - Function
    func login(username: String?, password: String?) -> Bool {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
            return false
        }
        return username == self.username && password == self.password
    }
}
