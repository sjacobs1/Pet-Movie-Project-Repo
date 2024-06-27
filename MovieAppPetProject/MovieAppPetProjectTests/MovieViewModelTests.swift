//
//  MovieAppPetProjectTests.swift
//  MovieAppPetProjectTests
//
//  Created by Sebastian Jacobs on 2024/05/07.
//

import XCTest
@testable import MovieAppPetProject

class MovieViewModelTests: XCTestCase {
    var viewModelUnderTest: MovieViewModel!
    var mockRepository: MockRepository!
    var mockDelegate: MockDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        mockDelegate = MockDelegate()
        viewModelUnderTest = MovieViewModel(movieRepository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModelUnderTest = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    class MockRepository: MovieRepositoryType {
        var shouldFail = false
        var shouldReturnEmptyArray = false
        var shouldReturnNilResults = false

        func fetchMovies(for category: MovieCategory, completion: @escaping FetchMoviesCompletion) {
            if shouldFail {
                completion(.failure(.internalError))
            } else if shouldReturnNilResults {
                let mockResponse = MovieResponse(results: nil)
                completion(.success(mockResponse))
            } else {
                let mockResponse = MovieResponse(results: shouldReturnEmptyArray ? [] : [
                    Movie(movieID: 1, originalTitle: "Mock Movie 1", moviePoster: "poster1"),
                    Movie(movieID: 2, originalTitle: "Mock Movie 2", moviePoster: "poster2")
                ])
                completion(.success(mockResponse))
            }
        }
    }

    class MockDelegate: MovieViewModelType {
        var startLoadingIndicatorCalled = false
        var stopLoadingIndicatorCalled = false
        var reloadViewCalled = false
        var handleFetchErrorCalled = false

        func startLoadingIndicator() {
            startLoadingIndicatorCalled = true
        }

        func stopLoadingIndicator() {
            stopLoadingIndicatorCalled = true
        }

        func reloadView() {
            reloadViewCalled = true
        }

        func handleFetchError(_ error: Error) {
            handleFetchErrorCalled = true
        }

        func reset() {
            startLoadingIndicatorCalled = false
            stopLoadingIndicatorCalled = false
            reloadViewCalled = false
            handleFetchErrorCalled = false
        }
    }

    func testFetchNowPlayingMoviesSuccessWithPopulatedArray() {
        fetchMoviesAndAssert(for: .nowPlaying)
    }

    func testFetchPopularMoviesSuccessWithPopulatedArray() {
        fetchMoviesAndAssert(for: .popular)
    }

    func testFetchTopRatedMoviesSuccessWithPopulatedArray() {
        fetchMoviesAndAssert(for: .topRated)
    }

    func testFetchUpcomingMoviesSuccessWithPopulatedArray() {
        fetchMoviesAndAssert(for: .upcoming)
    }

    private func fetchMoviesAndAssert(for category: MovieCategory) {
        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)

        mockDelegate.reset()
        viewModelUnderTest.fetchMovies(for: category)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertNotNil(fetchMoviesForCategory(category), "\(category) movies should not be nil")
        XCTAssertEqual(fetchMoviesForCategory(category)?.count ?? 0, 2, "\(category) movies count should be 2")
    }

    private func fetchMoviesForCategory(_ category: MovieCategory) -> [Movie]? {
        switch category {
        case .nowPlaying:
            return viewModelUnderTest.nowPlayingMovies
        case .popular:
            return viewModelUnderTest.popularMovies
        case .topRated:
            return viewModelUnderTest.topRatedMovies
        case .upcoming:
            return viewModelUnderTest.upcomingMovies
        }
    }

    func testFetchNowPlayingMoviesSuccessWithEmptyArray() {
        fetchMoviesWithEmptyArray(for: .nowPlaying)
    }

    func testFetchPopularMoviesSuccessWithEmptyArray() {
        fetchMoviesWithEmptyArray(for: .popular)
    }

    func testFetchTopRatedMoviesSuccessWithEmptyArray() {
        fetchMoviesWithEmptyArray(for: .topRated)
    }

    func testFetchUpcomingMoviesSuccessWithEmptyArray() {
        fetchMoviesWithEmptyArray(for: .upcoming)
    }

    private func fetchMoviesWithEmptyArray(for category: MovieCategory) {
        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)

        mockDelegate.reset()
        mockRepository.shouldReturnEmptyArray = true
        viewModelUnderTest.fetchMovies(for: category)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertTrue(fetchMoviesForCategory(category)?.isEmpty ?? false, "\(category) movies should be empty")
        XCTAssertNotNil(fetchMoviesForCategory(category), "\(category) movies should not be nil")
        XCTAssertEqual(fetchMoviesForCategory(category)?.count ?? 0, 0, "\(category) movies count should be 0")
    }

    func testFetchNowPlayingMoviesFailure() {
        fetchMoviesWithFailure(for: .nowPlaying)
    }

    func testFetchPopularMoviesFailure() {
        fetchMoviesWithFailure(for: .popular)
    }

    func testFetchTopRatedMoviesFailure() {
        fetchMoviesWithFailure(for: .topRated)
    }

    func testFetchUpcomingMoviesFailure() {
        fetchMoviesWithFailure(for: .upcoming)
    }

    private func fetchMoviesWithFailure(for category: MovieCategory) {
        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)

        mockDelegate.reset()
        mockRepository.shouldFail = true
        viewModelUnderTest.fetchMovies(for: category)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(fetchMoviesForCategory(category)?.isEmpty ?? false, "\(category) movies should be empty")
        XCTAssertTrue(mockDelegate.handleFetchErrorCalled, "handleFetchError should be called")
        XCTAssertFalse(mockDelegate.reloadViewCalled, "reloadView should not be called")
    }

    func testFetchMoviesWithNilResults() {
        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)

        mockDelegate.reset()
        mockRepository.shouldReturnNilResults = true
        viewModelUnderTest.fetchMovies(for: .nowPlaying)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertNotNil(viewModelUnderTest.nowPlayingMovies, "nowPlayingMovies should not be nil")
        XCTAssertTrue(viewModelUnderTest.nowPlayingMovies.isEmpty, "nowPlayingMovies should be empty")
        XCTAssertEqual(viewModelUnderTest.nowPlayingMovies.count, 0, "nowPlayingMovies count should be 0")
    }
}
