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
    private lazy var upcomingMoviesViewModel = UpcomingMoviesViewModel(upcomingMoviesRepository: UpcomingMoviesRepository(), delegate: self)
    private lazy var popularMoviesViewModel = PopularMoviesViewModel(popularMoviesRepository: PopularMoviesRepository(), delegate: self)
    private lazy var topRatedMoviesViewModel = TopRatedViewModel(topRatedMoviesRepository: TopRatedMoviesRepository(), delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMoviesViewModel.fetchMovies()
        nowPlayingViewModel.fetchNowPlayingMovies()
        upcomingMoviesViewModel.fetchMovies()
        topRatedMoviesViewModel.fetchMovies()
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
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: nowPlayingViewModel.nowPlayingMovies ?? [], sectionTitle: " Now Playing")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: popularMoviesViewModel.popularMovies ?? [], sectionTitle: " Popular")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: topRatedMoviesViewModel.topRatedMovies ?? [], sectionTitle: " Top Rated")
            cell.didSelectItem = { [weak self] movie in
                guard let self = self else { return }
                self.performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: movie.movieID)
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.homeScreenTableCell, for: indexPath) as? NewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: upcomingMoviesViewModel.upcomingMovies ?? [], sectionTitle: " Upcoming")
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
            movieDetailsVC.movieID = movieId
        }
    }
}

// MARK: - Delegate
extension NewHomeViewController: NowPlayingViewModelDelegate, UpcomingMoviesViewModelDelegate, PopularMoviesViewModelDelegate, TopRatedMoviesViewModelDelegate {
    func reloadView() {
        newTableView.reloadData()
    }
}
