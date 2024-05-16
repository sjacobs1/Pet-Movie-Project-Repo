//
//  SearchMovies-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import UIKit

class SearchMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet private weak var searchMovieTableView: UITableView!
    @IBOutlet private weak var searchMovie: UISearchBar!

    // MARK: - Variables
    private lazy var searchMoviesViewModel = SearchMoviesViewModel(searchMoviesRepository: SearchMoviesRepository(), delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchMoviesViewModel.fetchSearchedMovies()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchMoviesViewModel.searchMoviesCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.searchScreenTableViewCellNibIdentifier,
                                                       for: indexPath) as? SearchMovieTableViewCell else {
            return UITableViewCell()
        }

        let movie = searchMoviesViewModel.searchedMovies?[indexPath.row]
        let title = movie?.originalTitle
        if let posterPath = movie?.moviePoster {
            let posterURL = URL(string: "\(Constants.Path.moviePosterPath)\(posterPath)")
            cell.configure(with: posterURL, placeholderImage: UIImage(named: "Me"), title: title)
        } else {
            cell.configure(with: nil, placeholderImage: UIImage(named: "Me"), title: title)

        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = searchMoviesViewModel.searchedMovies?[indexPath.row]
        performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: selectedMovie?.movieID)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.goToMovieDetails,
            let movieDetailsViewCcontroller = segue.destination as? MovieDetailsViewController,
            let movieId = sender as? Int {
            movieDetailsViewCcontroller.setMovieID(movieID: movieId)
        }
    }

    private func setupTableView() {
        let nib = UINib(nibName: Constants.Identifiers.searchScreenTableViewCellNibIdentifier, bundle: nil)
        searchMovieTableView.register(nib, forCellReuseIdentifier: Constants.Identifiers.searchScreenTableViewCellNibIdentifier)
        searchMovieTableView.dataSource = self
        searchMovieTableView.delegate = self
    }
}

// MARK: - Delegate
extension SearchMoviesViewController: ViewModelDelegate {
    func reloadView() {
        searchMovieTableView.reloadData()
    }
}
