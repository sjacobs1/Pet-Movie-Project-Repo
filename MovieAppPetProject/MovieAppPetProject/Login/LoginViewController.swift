//
//  LoginViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/15.
//

import UIKit

class LoginViewController: UIViewController {

    let username = "Admin"
    let password = "DVTPassword"

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showAlert(alertTitle: String, alertMessage: String) {

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true)
        }

    }

    func incorrectEntries(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        self.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default))
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard let insertedUsername = usernameInput.text, !insertedUsername.isEmpty else {
            showAlert(alertTitle: "Username Required", alertMessage: "")
            return
        }

        guard let insertedPassword = passwordInput.text, !insertedPassword.isEmpty else {
            showAlert(alertTitle: "Password Required", alertMessage: "")
            return
        }

//        if insertedUsername == username && insertedPassword == password {
//            performseg
//        } else {
//            incorrectEntries(alertTitle: "Incorrect Username or Password", alertMessage: "")
//        }
    }

}
