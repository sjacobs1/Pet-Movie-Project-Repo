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
    private lazy var watchlistViewModel = WatchlistViewModel(watchlistRepository: WatchlistRepository(coreDataManager: CoreDataManager()), delegate: self)

    // MARK: - Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.savedMovieTableViewCell, for: indexPath) as? WatchlistTableViewCell else {
            return UITableViewCell()
        }

        let watchlistItem = watchlistViewModel.watchlistItems[indexPath.row]
        cell.configure(with: watchlistItem.originalTitle, item: watchlistItem)
        cell.delegate = self

        return cell
    }

    private func setupTableView() {
        let nib = UINib(nibName: Constants.Identifiers.savedMovieTableViewCell, bundle: nil)
        watchlistTableView.register(nib, forCellReuseIdentifier: Constants.Identifiers.savedMovieTableViewCell)
        watchlistTableView.dataSource = self
        watchlistTableView.delegate = self
    }
}

extension WatchlistScreenViewController: WatchlistViewModelType {
    func updateWatchlist() {
        watchlistTableView.reloadData()
    }
}

extension WatchlistScreenViewController: WatchlistTableViewCellType {
    func didRemoveItem(item: WatchList) {
        watchlistViewModel.deleteItem(item: item)
    }
}
