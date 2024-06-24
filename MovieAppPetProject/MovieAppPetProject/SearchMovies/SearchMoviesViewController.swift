//
//  SearchMoviesViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import UIKit

class SearchMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // MARK: - IBOutlets
    @IBOutlet private weak var searchMovieTableView: UITableView!
    @IBOutlet private weak var searchMovie: UISearchBar!
    @IBOutlet private weak var noResultsLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Variables
    private lazy var searchMoviesViewModel = SearchMoviesViewModel(searchMoviesRepository: SearchMoviesRepository(), delegate: self)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        noResultsLabel.isHidden = true
        activityIndicator.isHidden = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchMoviesViewModel.fetchSearchedMovies(with: query)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchMoviesViewModel.clearSearchResults()
        noResultsLabel.isHidden = true
        searchBar.resignFirstResponder()
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

        if let movie = searchMoviesViewModel.movie(at: indexPath.row) {
            let title = movie.originalTitle
            let voteAverage = searchMoviesViewModel.formattedVoteAverage(for: movie)
            let releaseDate = searchMoviesViewModel.formattedReleaseDate(for: movie)

            if let posterPath = movie.moviePoster {
                let posterURL = URL(string: "\(Constants.Path.moviePosterPath)\(posterPath)")
                cell.configure(with: posterURL, placeholderImage: UIImage(named: "Me"), title: title, voteAverage: voteAverage, releaseDate: releaseDate)
            } else {
                cell.configure(with: nil, placeholderImage: UIImage(named: "Me"), title: title, voteAverage: voteAverage, releaseDate: releaseDate)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = searchMoviesViewModel.movie(at: indexPath.row)
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

    private func setupSearchBar() {
        searchMovie.delegate = self
        if let cancelButton = searchMovie.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Clear", for: .normal)
        }
    }
}

// MARK: - Delegate
extension SearchMoviesViewController: ViewModelType {
    func startLoadingIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func stopLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func reloadView() {
        searchMovieTableView.reloadData()
    }

    func showNoResultsMessage() {
        noResultsLabel.isHidden = false
    }

    func hideNoResultsMessage() {
        noResultsLabel.isHidden = true
    }

    func displayError(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
