//
//  WatchlistScreenViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import UIKit

class WatchlistScreenViewController: UIViewController {

    // MARK: - Variable
    private let watchlistViewModel = WatchlistViewModel(coreDataManager: CoreDataManager())

    // MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        watchlistViewModel.fetchAndDisplayWatchlistItems() 
    }
}
