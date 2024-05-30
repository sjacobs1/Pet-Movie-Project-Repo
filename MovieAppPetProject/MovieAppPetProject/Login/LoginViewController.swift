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

    // MARK: - IBAction
    @IBAction private func loginTapped(_ sender: Any) {
        guard let username = usernameInput.text, let password = passwordInput.text else {
            return
        }
        loginViewModel.attemptLogin(username: username, password: password)
    }

    // MARK: - Variable
    private lazy var loginViewModel = LoginViewModel(delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlaceHolderText()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    func navigateToHomeScreen() {
        performSegue(withIdentifier: Constants.Identifiers.showHomeScreen, sender: self)
    }

    func displayError(message: String) {
        showAlert(alertTitle: "Incorrect Credentials", alertMessage: message)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 280
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    private func setUpPlaceHolderText() {
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }

    private func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
