//
//  WatchlistViewModelTests.swift
//  MovieAppPetProjectTests
//
//  Created by Sebastian Jacobs on 2024/06/27.
//

import XCTest
import CoreData
@testable import MovieAppPetProject

class MockCoreDataManager: CoreDataManager {
    var mockItems: [WatchList] = []

    override func fetchAllWatchlistItems() -> [WatchList] {
        return mockItems
    }

    override func createItem(movieDetails: MovieDetails) {
        let newItem = WatchList(context: context!)
        newItem.originalTitle = movieDetails.originalTitle
        newItem.moviePoster = movieDetails.moviePoster
        mockItems.append(newItem)
    }

    override func deleteItem(item: WatchList) {
        if let index = mockItems.firstIndex(of: item) {
            mockItems.remove(at: index)
        }
    }
}

class WatchlistViewModelTests: XCTestCase {
    var viewModel: WatchlistViewModel!
    var mockRepository: WatchlistRepository!
    var mockDelegate: MockWatchlistViewModelDelegate!
    var mockCoreDataManager: MockCoreDataManager!

    override func setUp() {
        super.setUp()
        mockCoreDataManager = MockCoreDataManager()
        mockRepository = WatchlistRepository(coreDataManager: mockCoreDataManager)
        mockDelegate = MockWatchlistViewModelDelegate()
        viewModel = WatchlistViewModel(watchlistRepository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        mockCoreDataManager = nil
        super.tearDown()
    }

    func testFetchAndDisplayWatchlistItems() {
        let movieDetails = MovieDetails(originalTitle: "Test Movie",
                                        overview: "Test movie overview",
                                        moviePoster: "test_poster_path",
                                        releaseDate: "2023-06-26",
                                        runtime: 120,
                                        status: "Released",
                                        voteAverage: 8.0)

        mockCoreDataManager.createItem(movieDetails: movieDetails)
        viewModel.fetchAndDisplayWatchlistItems()

        XCTAssertEqual(viewModel.savedMoviesCount, 1)
        XCTAssertTrue(mockDelegate.updateWatchlistCalled)
    }

    func testDeleteItem() {
        let movieDetails = MovieDetails(originalTitle: "Test Movie",
                                        overview: "Test movie overview",
                                        moviePoster: "test_poster_path",
                                        releaseDate: "2023-06-26",
                                        runtime: 120,
                                        status: "Released",
                                        voteAverage: 8.0)

        mockCoreDataManager.createItem(movieDetails: movieDetails)
        viewModel.fetchAndDisplayWatchlistItems()

        XCTAssertEqual(viewModel.savedMoviesCount, 1)

        viewModel.deleteItem(item: viewModel.watchlistItems[0])

        XCTAssertEqual(viewModel.savedMoviesCount, 0)
        XCTAssertTrue(mockDelegate.updateWatchlistCalled)
    }

    func testFetchAndDisplayWatchlistItemsEmpty() {
        viewModel.fetchAndDisplayWatchlistItems()

        XCTAssertEqual(viewModel.savedMoviesCount, 0)
        XCTAssertTrue(mockDelegate.updateWatchlistCalled)
    }
}

class MockWatchlistViewModelDelegate: WatchlistViewModelType {
    var updateWatchlistCalled = false

    func updateWatchlist() {
        updateWatchlistCalled = true
    }
}

