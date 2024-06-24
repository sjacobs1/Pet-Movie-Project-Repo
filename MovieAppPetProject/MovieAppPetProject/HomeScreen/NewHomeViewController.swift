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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Variables
    private lazy var movieViewModel = MovieViewModel(movieRepository: MovieRepository(), delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        loadMovies()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case 0:
            cell.configure(with: movieViewModel.nowPlayingMovies, sectionTitle: "  Now Playing")
        case 1:
            cell.configure(with: movieViewModel.popularMovies, sectionTitle: "  Popular")
        case 2:
            cell.configure(with: movieViewModel.topRatedMovies, sectionTitle: "  Top Rated")
        case 3:
            cell.configure(with: movieViewModel.upcomingMovies, sectionTitle: "  Upcoming")
        default:
            return UITableViewCell()
        }
        cell.didSelectItem = { [weak self] movie in
            guard let self = self else { return }
            self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.goToMovieDetails,
           let movieDetailsVC = segue.destination as? MovieDetailsViewController,
           let movieId = sender as? Int {
            movieDetailsVC.setMovieID(movieID: movieId)
        }
    }

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }

    private func loadMovies() {
        movieViewModel.fetchMovies(for: .nowPlaying)
        movieViewModel.fetchMovies(for: .popular)
        movieViewModel.fetchMovies(for: .topRated)
        movieViewModel.fetchMovies(for: .upcoming)
    }
}

// MARK: - Delegate
extension NewHomeViewController: MovieViewModelType {
    func startLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func reloadView() {
        newTableView.reloadData()
    }
    
    func handleFetchError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
