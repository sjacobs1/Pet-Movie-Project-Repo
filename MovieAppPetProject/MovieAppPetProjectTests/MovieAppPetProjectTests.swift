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

        func fetchMovies(for category: MovieCategory, completion: @escaping FetchMoviesCompletion) {
            if shouldFail {
                completion(.failure(.internalError))
            } else {
                let mockResponse = MovieResponse(results: shouldReturnEmptyArray ? nil : [
                    Movie(movieID: 1, originalTitle: "Mock Movie 1", moviePoster: "poster1"),
                    Movie(movieID: 2, originalTitle: "Mock Movie 2", moviePoster: "poster2")
                ])
                completion(.success(mockResponse))
            }
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

        viewModelUnderTest.fetchMovies(for: category)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertNotNil(getMoviesForCategory(category), "\(category) movies should not be nil")
        XCTAssertEqual(getMoviesForCategory(category)?.count ?? 0, 2, "\(category) movies count should be 2")
    }

    private func getMoviesForCategory(_ category: MovieCategory) -> [Movie]? {
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
        mockRepository.shouldReturnEmptyArray = true

        viewModelUnderTest.fetchMovies(for: category)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertTrue(getMoviesForCategory(category)?.isEmpty ?? false, "\(category) movies should be empty")
        XCTAssertNotNil(getMoviesForCategory(category), "\(category) movies should not be nil")
        XCTAssertEqual(getMoviesForCategory(category)?.count ?? 0, 0, "\(category) movies count should be 0")
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
        mockRepository.shouldFail = true

        viewModelUnderTest.fetchMovies(for: category)

        XCTAssertTrue(mockDelegate.startLoadingIndicatorCalled, "startLoadingIndicator should be called")
        XCTAssertTrue(mockDelegate.stopLoadingIndicatorCalled, "stopLoadingIndicator should be called")
        XCTAssertTrue(getMoviesForCategory(category)?.isEmpty ?? false, "\(category) movies should be empty")
        XCTAssertFalse(mockDelegate.reloadViewCalled, "reloadView should not be called")
    }
}

class MockDelegate: MovieViewModelType {
    var startLoadingIndicatorCalled = false
    var stopLoadingIndicatorCalled = false
    var reloadViewCalled = false

    func startLoadingIndicator() {
        startLoadingIndicatorCalled = true
    }

    func stopLoadingIndicator() {
        stopLoadingIndicatorCalled = true
    }

    func reloadView() {
        reloadViewCalled = true
    }
}
