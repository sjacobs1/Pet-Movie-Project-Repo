//
//  NewHomeViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit

class NewHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet private weak var newTableView: UITableView!

    // MARK: - Variables
    private lazy var nowPlayingViewModel = NowPlayingViewModel(nowPlayingRepository: NowPlayingRepository(), delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingViewModel.fetchNowPlayingMovies()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell,
                                                       for: indexPath) as? NewTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: nowPlayingViewModel.nowPlayingMovies ?? [] )
        cell.didSelectItem = { [weak self] movie in
            guard let self = self else { return }
            self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie)
        }
        return cell
    }
}

// MARK: - Delegate
extension NewHomeViewController: NowPlayingViewModelDelegate {
    func reloadView() {
        newTableView.reloadData()
    }
}
