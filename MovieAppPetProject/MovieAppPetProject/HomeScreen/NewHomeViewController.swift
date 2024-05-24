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
    private lazy var nowPlayingMovies = MoviesViewModel(moviesRepository: MoviesRepository(), category: .nowPlaying, delegate: self)
    private lazy var popularMovies = MoviesViewModel(moviesRepository: MoviesRepository(), category: .popular, delegate: self)
    private lazy var upcomingMovies = MoviesViewModel(moviesRepository: MoviesRepository(), category: .upcoming, delegate: self)
    private lazy var topRatedMovies = MoviesViewModel(moviesRepository: MoviesRepository(), category: .topRated, delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMovies.fetchMovies()
        nowPlayingMovies.fetchMovies()
        upcomingMovies.fetchMovies()
        topRatedMovies.fetchMovies()
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
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: nowPlayingMovies.movies ?? [], sectionTitle: "  Now Playing")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: popularMovies.movies ?? [], sectionTitle: "  Popular")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: topRatedMovies.movies ?? [], sectionTitle: "  Top Rated")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: upcomingMovies.movies ?? [], sectionTitle: "  Upcoming")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.goToMovieDetails,
           let movieDetailsVC = segue.destination as? MovieDetailsViewController,
           let movieId = sender as? Int {
            movieDetailsVC.setMovieID(movieID: movieId)
        }
    }
}

// MARK: - Delegate
extension NewHomeViewController: MoviesViewModelType {
    func reloadView() {
        newTableView.reloadData()
    }
}
