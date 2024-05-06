//
//  LoginViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/15.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var usernameInput: UITextField!
    @IBOutlet private weak var passwordInput: UITextField!

    // MARK: - Variable
    private let loginViewModel = LoginViewModel()

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }

    @IBAction private func loginTapped(_ sender: Any) {
        let username = usernameInput.text
        let password = passwordInput.text

        if loginViewModel.login(username: username, password: password) {
            performSegue(withIdentifier: Constants.Identifiers.showHomeScreen, sender: self)
        } else {
            showAlert(alertTitle: "Incorrect Credentials", alertMessage: "The username or password is incorrect.")
        }
    }

    private func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
