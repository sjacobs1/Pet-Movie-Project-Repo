//
//  LoginViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/15.
//

import UIKit

class LoginViewController: UIViewController, LoginViewModelDelegate {

    // MARK: - Outlets
    @IBOutlet private weak var usernameInput: UITextField!
    @IBOutlet private weak var passwordInput: UITextField!

    // MARK: - Variable
    private var loginViewModel: LoginViewModel!

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel(delegate: self)
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }

    @IBAction private func loginTapped(_ sender: Any) {
        guard let username = usernameInput.text, let password = passwordInput.text else {
            return
        }
        loginViewModel.attemptLogin(username: username, password: password)
    }

    func navigateToHomeScreen() {
        performSegue(withIdentifier: Constants.Identifiers.showHomeScreen, sender: self)
    }

    func displayError(message: String) {
        showAlert(alertTitle: "Incorrect Credentials", alertMessage: message)
    }

    private func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
