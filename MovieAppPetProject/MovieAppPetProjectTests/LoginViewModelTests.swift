//
//  LoginViewModelTests.swift
//  MovieAppPetProjectTests
//
//  Created by Sebastian Jacobs on 2024/06/24.
//

import XCTest
@testable import MovieAppPetProject

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockDelegate: MockDelegate!

    override func setUp() {
        super.setUp()
        mockDelegate = MockDelegate()
        viewModel = LoginViewModel(delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        let username = "Admin"
        let password = "DVTPassword"

        viewModel.attemptLogin(username: username, password: password)

        XCTAssertTrue(mockDelegate.navigateToHomeScreenCalled)
        XCTAssertFalse(mockDelegate.displayErrorCalled)
    }

    func testLoginFailureWithIncorrectCredentials() {
        let username = "Admin"
        let password = "monday@123"

        viewModel.attemptLogin(username: username, password: password)

        XCTAssertFalse(mockDelegate.navigateToHomeScreenCalled)
        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "The username or password is incorrect.")
    }

    func testLoginFailureWithEmptyUsername() {
        let username = ""
        let password = "DVTPassword"

        viewModel.attemptLogin(username: username, password: password)

        XCTAssertFalse(mockDelegate.navigateToHomeScreenCalled)
        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Username and password required.")
    }

    func testLoginFailureWithEmptyPassword() {
        let username = "Admin"
        let password = ""

        viewModel.attemptLogin(username: username, password: password)

        XCTAssertFalse(mockDelegate.navigateToHomeScreenCalled)
        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Username and password required.")
    }

    func testLoginFailureWithEmptyUsernameAndPassword() {
        let username = ""
        let password = ""

        viewModel.attemptLogin(username: username, password: password)

        XCTAssertFalse(mockDelegate.navigateToHomeScreenCalled)
        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Username and password required.")
    }
}

class MockDelegate: LoginViewModelDelegate {
    var navigateToHomeScreenCalled = false
    var displayErrorCalled = false
    var errorMessage: String?

    func navigateToHomeScreen() {
        navigateToHomeScreenCalled = true
    }

    func displayError(message: String) {
        displayErrorCalled = true
        errorMessage = message
    }

    func reset() {
        navigateToHomeScreenCalled = false
        displayErrorCalled = false
        errorMessage = nil
    }
}
