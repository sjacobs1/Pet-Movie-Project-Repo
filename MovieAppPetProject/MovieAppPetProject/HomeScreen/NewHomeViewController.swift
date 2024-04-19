//
//  NewHomeViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit
import SDWebImage

class NewHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let nowPlayingViewModel = NowPlayingViewModel()

    @IBOutlet weak var newTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNowPlayingMovies()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetails",
           let movieDetailsVC = segue.destination as? MovieDetailsViewController {
            if let selectedNowPlayingMovie = sender as? NowPlayingResults {
                movieDetailsVC.selectedHomeScreenMovies = selectedNowPlayingMovie
            } else if let selectedSearchMovie = sender as? SearchMoviesResults {
                movieDetailsVC.selectedSearchMovie = selectedSearchMovie
            }
        }
    }

    func fetchNowPlayingMovies() {
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseTableCell", for: indexPath) as? NewTableViewCell else {
            fatalError("Unable to dequeue NewTableViewCell.")
        }
        cell.configure(with: nowPlayingViewModel.nowPlayingMovies)
        cell.parentViewController = self
        return cell
    }
}
