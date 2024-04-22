//
//  SearchMovies-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import UIKit

class SearchMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let searchMoviesViewModel = SearchMoviesViewModel()

    @IBOutlet private weak var searchMovieTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Constants.Identifiers.nibIdentifier, bundle: nil)
        searchMovieTableView.register(nib, forCellReuseIdentifier: Constants.Identifiers.tableCellReuseIdentifier)
        searchMovieTableView.dataSource = self
        searchMovieTableView.delegate = self
        searchMoviesViewModel.fetchSearchedMovies(completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.searchMovieTableView.reloadData()
            }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMoviesViewModel.searchedMovies.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.tableCellReuseIdentifier, for: indexPath) as? SearchMovieTableViewCell else {
            return UITableViewCell()
        }

        let movie = searchMoviesViewModel.searchedMovies[indexPath.row]
        let title = movie.originalTitle
        if let posterPath = movie.moviePoster {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.configure(with: posterURL, placeholderImage: UIImage(named: "Me"), title: title)
        } else {
            cell.configure(with: nil, placeholderImage: UIImage(named: "Me"), title: title)

        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = searchMoviesViewModel.searchedMovies[indexPath.row]
        performSegue(withIdentifier: Constants.Identifiers.goToMovieDetails, sender: selectedMovie)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.goToMovieDetails,
           let movieDetailsVC = segue.destination as? MovieDetailsViewController {
            if let selectedSearchMovie = sender as? SearchMoviesResults {
                movieDetailsVC.setMovieDetails(selectedSearchMovie: selectedSearchMovie)
            }
        }
    }
}
