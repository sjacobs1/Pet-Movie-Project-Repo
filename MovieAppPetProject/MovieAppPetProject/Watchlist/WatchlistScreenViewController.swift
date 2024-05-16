//
//  WatchlistScreenViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/14.
//

import UIKit

class WatchlistScreenViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var watchlistTableView: UITableView!

    // MARK: - Variable
    private lazy var watchlistViewModel = WatchlistViewModel(watchlistRepository: WatchlistRepository(coreDataManager: CoreDataManager()))

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        watchlistViewModel.fetchAndDisplayWatchlistItems()
    }
}

// MARK: - Extention
extension WatchlistScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchlistViewModel.savedMoviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistTableViewCell", for: indexPath) as? WatchlistTableViewCell else {
            return UITableViewCell()
        }

        let watchlistItems = watchlistViewModel.fetchAndDisplayWatchlistItems()
        let watchlistItem = watchlistItems[indexPath.row]
        cell.configure(with: watchlistItem.originalTitle, item: watchlistItem)

        return cell
    }

    private func setupTableView() {
        let nib = UINib(nibName: Constants.Identifiers.savedMovieTableViewCell, bundle: nil)
        watchlistTableView.register(nib, forCellReuseIdentifier: Constants.Identifiers.savedMovieTableViewCell)
        watchlistTableView.dataSource = self
        watchlistTableView.delegate = self
    }
}
