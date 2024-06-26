//
//  LoginViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/05.
//

protocol LoginViewModelDelegate: AnyObject {
    func navigateToHomeScreen()
    func displayError(message: String)
}

import Foundation

class LoginViewModel {

    // MARK: - Variables
    private let username = "Admin"
    private let password = "DVTPassword"
    weak var delegate: LoginViewModelDelegate?

    // MARK: - Initializer
    init(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Function
    func attemptLogin(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            delegate?.displayError(message: "Username and password required.")
            return
        }
        if login(username: username, password: password) {
            delegate?.navigateToHomeScreen()
        } else {
            delegate?.displayError(message: "The username or password is incorrect.")
        }
    }

    private func login(username: String, password: String) -> Bool {
        return username == self.username && password == self.password
    }
}
