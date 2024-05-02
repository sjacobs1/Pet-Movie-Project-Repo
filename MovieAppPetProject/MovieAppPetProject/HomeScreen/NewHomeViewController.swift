//
//  NewHomeViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit
import SDWebImage

class NewHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet private weak var newTableView: UITableView!

    // MARK: - Variables
    private let nowPlayingViewModel = NowPlayingViewModel()

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNowPlayingMovies()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.Identifiers.goToMovieDetails,
              let movieDetailsViewController = segue.destination as? MovieDetailsViewController,
              let selectedNowPlayingMovie = sender as? NowPlayingResults else {
            return
        }

        let viewModel = MovieDetailsViewModel()
        viewModel.setMovieDetails(selectedSearchMovie: nil, selectedHomeScreenMovies: selectedNowPlayingMovie)
        movieDetailsViewController.viewModel = viewModel
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
        cell.configure(with: nowPlayingViewModel.nowPlayingMovies)
        cell.didSelectItem = { [weak self] movie in
            guard let self = self else { return }
            self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie)
        }
        return cell
    }

    private func fetchNowPlayingMovies() {
        nowPlayingViewModel.fetchNowPlayingMovies { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.newTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching now playing movies: \(error)")
            }
        }
    }
}
