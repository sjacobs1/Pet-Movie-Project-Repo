//
//  MovieDetailsViewModelTests.swift
//  MovieAppPetProjectTests
//
//  Created by Sebastian Jacobs on 2024/06/27.
//

import XCTest
@testable import MovieAppPetProject

class MovieDetailsViewModelTests: XCTestCase {
    var viewModel: MovieDetailsViewModel!
    var mockRepository: MockMovieDetailsRepository!
    var mockDelegate: MockMovieDetailsViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieDetailsRepository()
        mockDelegate = MockMovieDetailsViewModelDelegate()
        viewModel = MovieDetailsViewModel(movieDetailsRepository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchMovieDetailsSuccess() {
        let movieDetails = MovieDetails(originalTitle: "Iron Man", overview: "Tony Stark is Iron Man",
                                        moviePoster: "mockExtension", releaseDate: "2008-01-01", runtime: 120,
                                        status: "Released", voteAverage: 8.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        viewModel.updateMovieID(movieID: 1)

        XCTAssertEqual(viewModel.originalTitle, "Iron Man")
        XCTAssertEqual(viewModel.overview, "Tony Stark is Iron Man")
        XCTAssertEqual(viewModel.releaseDate, "2008")
        XCTAssertEqual(viewModel.runTime, 120)
        XCTAssertEqual(viewModel.moviePosterURL, URL(string: "\(Constants.Path.moviePosterPath)mockExtension"))
        XCTAssertEqual(viewModel.voteAverage, 8.0)
        XCTAssertEqual(viewModel.status, "Released")
        XCTAssertTrue(mockDelegate.updateMovieDetailsUICalled)
    }

    func testFetchMovieDetailsFailure() {
        mockRepository.movieDetailsResult = .failure(.internalError)
        viewModel.updateMovieID(movieID: 1)

        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "The operation couldn’t be completed. (MovieAppPetProject.CustomError error 0.)")
    }

    func testFetchMovieDetailsEmptyOriginalTitle() {
        let movieDetails = MovieDetails(originalTitle: "", overview: "This movie is about nothing",
                                        moviePoster: "mockExtension", releaseDate: "2020-02-10", runtime: 118,
                                        status: "Released", voteAverage: 2.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        viewModel.updateMovieID(movieID: 1)

        XCTAssertEqual(viewModel.originalTitle, "")
        XCTAssertEqual(viewModel.overview, "This movie is about nothing")
        XCTAssertEqual(viewModel.releaseDate, "2020")
        XCTAssertEqual(viewModel.runTime, 118)
        XCTAssertEqual(viewModel.moviePosterURL, URL(string: "\(Constants.Path.moviePosterPath)mockExtension"))
        XCTAssertEqual(viewModel.voteAverage, 2.0)
        XCTAssertEqual(viewModel.status, "Released")
        XCTAssertFalse(viewModel.isMovieSaved)
    }

    func testFetchMovieDetailsNilOriginalTitle() {
        let movieDetails = MovieDetails(originalTitle: nil, overview: "The tales of a family",
                                        moviePoster: "mockExtension", releaseDate: "2018-12-22", runtime: 127,
                                        status: "Released", voteAverage: 6.5)

        mockRepository.movieDetailsResult = .success(movieDetails)
        viewModel.updateMovieID(movieID: 1)

        XCTAssertNil(viewModel.originalTitle)
        XCTAssertEqual(viewModel.overview, "The tales of a family")
        XCTAssertEqual(viewModel.releaseDate, "2018")
        XCTAssertEqual(viewModel.runTime, 127)
        XCTAssertEqual(viewModel.moviePosterURL, URL(string: "\(Constants.Path.moviePosterPath)mockExtension"))
        XCTAssertEqual(viewModel.voteAverage, 6.5)
        XCTAssertEqual(viewModel.status, "Released")
        XCTAssertFalse(viewModel.isMovieSaved)
    }

    func testAddToWatchlistSuccess() {
        let movieDetails = MovieDetails(originalTitle: "Mock Movie", overview: "Mock overview text",
                                        moviePoster: "mockExtension", releaseDate: "2020-11-03", runtime: 110,
                                        status: "Released", voteAverage: 5.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        mockRepository.isMovieSavedResult = false

        viewModel.updateMovieID(movieID: 1)
        viewModel.addToWatchlist()

        XCTAssertTrue(mockRepository.addToWatchlistCalled)
        XCTAssertTrue(viewModel.isMovieSaved)
        XCTAssertTrue(mockDelegate.updateMovieDetailsUICalled)
    }

    func testAddToWatchlistFailure() {
        let movieDetails = MovieDetails(originalTitle: "Stuart Little", overview: "Test Overview",
                                        moviePoster: "mockExtension", releaseDate: "2004-01-01", runtime: 142,
                                        status: "Released", voteAverage: 8.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        mockRepository.isMovieSavedResult = true

        viewModel.updateMovieID(movieID: 1)
        viewModel.addToWatchlist()

        XCTAssertFalse(mockRepository.addToWatchlistCalled)
        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Movie is already in the watchlist.")
    }

    func testReleaseDateIsNil() {
        let movieDetails = MovieDetails(originalTitle: "Taken", overview: "A man's daughter is taken",
                                        moviePoster: "mockExtension", releaseDate: nil, runtime: 160,
                                        status: "Released", voteAverage: 8.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        viewModel.updateMovieID(movieID: 1)

        XCTAssertNil(viewModel.releaseDate)
    }

    func testMoviePosterURLIsNilWhenEmpty() {
        let movieDetails = MovieDetails(originalTitle: "Wizard of Oz", overview: "Strange movie",
                                        moviePoster: "", releaseDate: "1995-09-19", runtime: 115,
                                        status: "Released", voteAverage: 8.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        viewModel.updateMovieID(movieID: 1)

        XCTAssertNil(viewModel.moviePosterURL)
    }

    func testAddToWatchlistGuardReturn() {
        let movieDetails = MovieDetails(originalTitle: "Shrek", overview: "An ogre gets a family",
                                        moviePoster: "mockExtension", releaseDate: "2002-01-01", runtime: 137,
                                        status: "Released", voteAverage: 8.0)

        mockRepository.movieDetailsResult = .success(movieDetails)
        mockRepository.isMovieSavedResult = true

        viewModel.updateMovieID(movieID: 1)
        viewModel.addToWatchlist()

        XCTAssertFalse(mockRepository.addToWatchlistCalled)
        XCTAssertTrue(mockDelegate.displayErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Movie is already in the watchlist.")
    }
}

class MockMovieDetailsRepository: MovieDetailsRepositoryType {
    var movieDetailsResult: Result<MovieDetails, CustomError>?
    var isMovieSavedResult: Bool = false
    var addToWatchlistCalled: Bool = false

    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, CustomError>) -> Void) {
        if let result = movieDetailsResult {
            completion(result)
        }
    }

    func isMovieSaved(movieTitle: String) -> Bool {
        return isMovieSavedResult
    }

    func addToWatchlist(movieDetails: MovieDetails) {
        addToWatchlistCalled = true
    }
}

class MockMovieDetailsViewModelDelegate: MovieDetailsViewModelType {
    var updateMovieDetailsUICalled: Bool = false
    var displayErrorCalled: Bool = false
    var errorMessage: String?

    func updateMovieDetailsUI() {
        updateMovieDetailsUICalled = true
    }

    func displayError(with message: String) {
        displayErrorCalled = true
        errorMessage = message
    }
}

