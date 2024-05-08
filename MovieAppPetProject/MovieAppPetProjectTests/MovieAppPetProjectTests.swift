//
//  MovieAppPetProjectTests.swift
//  MovieAppPetProjectTests
//
//  Created by Sebastian Jacobs on 2024/05/07.
//

import XCTest
@testable import MovieAppPetProject

class NowPlayingViewModelTests: XCTestCase {

    var viewModelUnderTest: NowPlayingViewModel!
    var mockRepository: MockRepository!
    var mockDelegate: MockDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        mockDelegate = MockDelegate()
        viewModelUnderTest = NowPlayingViewModel(nowPlayingRepository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModelUnderTest = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    class MockRepository: NowPlayingRepositoryType {
        var shouldFail = false
        var shouldReturnEmptyArray = false

        func fetchMovies(completion: @escaping (Result<NowPlaying, CustomError>) -> Void) {
            if shouldFail {
                completion(.failure(.internalError))
            } else {
                let mockNowPlaying = NowPlaying(results: shouldReturnEmptyArray ? nil : [
                    NowPlayingResults(movieID: 1, originalTitle: "Mock Movie 1", moviePoster: "poster1"),
                    NowPlayingResults(movieID: 2, originalTitle: "Mock Movie 2", moviePoster: "poster2")
                ])
                completion(.success(mockNowPlaying))
            }
        }
    }

    func testFetchNowPlayingMoviesSuccessWithPopulatedArray() {

        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)

        viewModelUnderTest.fetchNowPlayingMovies()

        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertNotNil(viewModelUnderTest.nowPlayingMovies, "nowPlayingMovies should not be nil")
        XCTAssertEqual(viewModelUnderTest.nowPlayingMovies?.count, 2, "nowPlayingMovies count should be 2")
    }

    func testFetchNowPlayingMoviesSuccessWithEmptyArray() {

        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)
        mockRepository.shouldReturnEmptyArray = true

        viewModelUnderTest.fetchNowPlayingMovies()

        XCTAssertTrue(viewModelUnderTest.nowPlayingMovies?.isEmpty ?? false, "nowPlayingMovies should be empty")
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called")
        XCTAssertNotNil(viewModelUnderTest.nowPlayingMovies, "nowPlayingMovies should not be nil")
        XCTAssertEqual(viewModelUnderTest.nowPlayingMovies?.count, 0, "nowPlayingMovies count should be 0")
    }

    func testFetchNowPlayingMoviesFailure() {

        XCTAssertNotNil(viewModelUnderTest)
        XCTAssertNotNil(mockRepository)
        XCTAssertNotNil(mockDelegate)
        mockRepository.shouldFail = true

        viewModelUnderTest.fetchNowPlayingMovies()

        XCTAssertTrue(viewModelUnderTest.nowPlayingMovies?.isEmpty ?? false, "nowPlayingMovies should be empty")
        XCTAssertFalse(mockDelegate.reloadViewCalled, "reloadView should not be called")
    }
}

class MockDelegate: NowPlayingViewModelDelegate {

    var reloadViewCalled = false

    func reloadView() {
        reloadViewCalled = true
    }
}
