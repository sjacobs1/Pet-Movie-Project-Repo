//
//  SearchMoviesViewModelTests.swift
//  MovieAppPetProjectTests
//
//  Created by Sebastian Jacobs on 2024/06/25.
//

import XCTest
@testable import MovieAppPetProject

class SearchMoviesViewModelTests: XCTestCase {
    var viewModel: SearchMoviesViewModel!
    var mockRepository: MockSearchMoviesRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockSearchMoviesRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = SearchMoviesViewModel(searchMoviesRepository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchSearchedMoviesSuccessWithResults() {
        let movie = SearchMoviesResults(movieID: 1, originalTitle: "Test Movie",
                                        moviePoster: "poster_path", voteAverage: 8.0,
                                        releaseDate: "2023-06-26")
        let searchMovies = SearchMovies(results: [movie])

        mockRepository.result = .success(searchMovies)
        viewModel.fetchSearchedMovies(with: "Test")

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled)
        XCTAssertTrue(mockDelegate.hideNoResultsMessageCalled)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled)
        XCTAssertEqual(viewModel.searchMoviesCount, 1)
    }

    func testFetchSearchedMoviesSuccessWithNoResults() {
        let searchMovies = SearchMovies(results: [])

        mockRepository.result = .success(searchMovies)
        viewModel.fetchSearchedMovies(with: "Test")

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled)
        XCTAssertTrue(mockDelegate.showNoResultsMessageCalled)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled)
        XCTAssertEqual(viewModel.searchMoviesCount, 0)
    }

    func testFetchSearchedMoviesSuccessWithNilResults() {
        mockRepository.result = .success(SearchMovies(results: nil))
        viewModel.fetchSearchedMovies(with: "Test")

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled)
        XCTAssertTrue(mockDelegate.showNoResultsMessageCalled)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled)
        XCTAssertEqual(viewModel.searchMoviesCount, 0)
    }

    func testFetchSearchedMoviesFailure() {
        mockRepository.shouldReturnError = true
        viewModel.fetchSearchedMovies(with: "Test")

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled)
        XCTAssertEqual(mockDelegate.displayErrorMessage, CustomError.internalError.localizedDescription)
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled)
    }

    func testClearSearchResults() {
        viewModel.clearSearchResults()

        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertTrue(mockDelegate.showNoResultsMessageCalled)
        XCTAssertEqual(viewModel.searchMoviesCount, 0)
    }

    func testSearchMoviesCountDefault() {
        viewModel = SearchMoviesViewModel(searchMoviesRepository: mockRepository, delegate: mockDelegate)

        XCTAssertEqual(viewModel.searchMoviesCount, 0)
    }

    func testFormattedVoteAverage() {
        let movie = SearchMoviesResults(movieID: 1, originalTitle: "Test Movie",
                                        moviePoster: "poster_path", voteAverage: 8.0,
                                        releaseDate: "2023-06-26")

        let formattedVoteAverage = viewModel.formattedVoteAverage(for: movie)
        XCTAssertEqual(formattedVoteAverage, "Rating: 8.0/10")

        let formattedVoteAverageNil = viewModel.formattedVoteAverage(for: nil)
        XCTAssertEqual(formattedVoteAverageNil, "Rating: N/A")
    }

    func testFormattedReleaseDate() {
        let movie = SearchMoviesResults(movieID: 1, originalTitle: "Test Movie",
                                        moviePoster: "poster_path", voteAverage: 8.0,
                                        releaseDate: "2023-06-26")

        let formattedReleaseDate = viewModel.formattedReleaseDate(for: movie)
        XCTAssertEqual(formattedReleaseDate, "Release year: 2023")

        let formattedReleaseDateNil = viewModel.formattedReleaseDate(for: nil)
        XCTAssertEqual(formattedReleaseDateNil, "Release year: N/A")

        let movieInvalidDate = SearchMoviesResults(movieID: 1, originalTitle: "Test Movie",
                                                   moviePoster: "poster_path", voteAverage: 8.0,
                                                   releaseDate: "23")
        let formattedReleaseDateInvalid = viewModel.formattedReleaseDate(for: movieInvalidDate)
        XCTAssertEqual(formattedReleaseDateInvalid, "Release year: N/A")
    }

    func testMovieAt() {
        let movie = SearchMoviesResults(movieID: 1, originalTitle: "Test Movie",
                                        moviePoster: "poster_path", voteAverage: 8.0,
                                        releaseDate: "2023-06-26")

        mockRepository.result = .success(SearchMovies(results: [movie]))
        viewModel.fetchSearchedMovies(with: "Test")

        let fetchedMovie = viewModel.movie(at: 0)
        XCTAssertNotNil(fetchedMovie)
        XCTAssertEqual(fetchedMovie?.movieID, 1)

        let invalidMovie = viewModel.movie(at: 1)
        XCTAssertNil(invalidMovie)
    }

    func testMovieAtWithDefaultValue() {
        viewModel = SearchMoviesViewModel(searchMoviesRepository: mockRepository, delegate: mockDelegate)

        let movie = viewModel.movie(at: 0)

        XCTAssertNil(movie)
    }

    func testFetchSearchedMoviesSuccessWithEmptyArray() {
        let searchMovies = SearchMovies(results: [])

        mockRepository.result = .success(searchMovies)
        viewModel.fetchSearchedMovies(with: "Test")

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled)
        XCTAssertTrue(mockDelegate.showNoResultsMessageCalled)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled)
        XCTAssertEqual(viewModel.searchMoviesCount, 0)
    }

    func testFetchSearchedMoviesSuccessWithEmptyResultsAndDefaultValueTrue() {
        mockRepository.result = .success(SearchMovies(results: nil))
        viewModel.fetchSearchedMovies(with: "Test")

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled)
        XCTAssertTrue(mockDelegate.showNoResultsMessageCalled)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled)
        XCTAssertEqual(viewModel.searchMoviesCount, 0)
    }
}

class MockSearchMoviesRepository: SearchMoviesRepositoryType {
    var shouldReturnError = false
    var result: Result<SearchMovies, CustomError>?

    func fetchSearchedMovies(query: String, completion: @escaping SearchMoviesCompletion) {
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            completion(result!)
        }
    }
}

class MockViewModelDelegate: ViewModelType {
    var reloadViewCalled = false
    var showNoResultsMessageCalled = false
    var hideNoResultsMessageCalled = false
    var startLoadingIndicatorCalled = false
    var stopLoadingIndicatorCalled = false
    var displayErrorMessage: String?

    func reloadView() {
        reloadViewCalled = true
    }

    func showNoResultsMessage() {
        showNoResultsMessageCalled = true
    }

    func hideNoResultsMessage() {
        hideNoResultsMessageCalled = true
    }

    func startLoadingIndicator() {
        startLoadingIndicatorCalled = true
    }

    func stopLoadingIndicator() {
        stopLoadingIndicatorCalled = true
    }

    func displayError(with message: String) {
        displayErrorMessage = message
    }

    func reset() {
        reloadViewCalled = false
        showNoResultsMessageCalled = false
        hideNoResultsMessageCalled = false
        startLoadingIndicatorCalled = false
        stopLoadingIndicatorCalled = false
        displayErrorMessage = nil
    }
}
