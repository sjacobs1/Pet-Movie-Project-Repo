//
//  GetMovieDetails-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var runTime: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    @IBOutlet private weak var status: UILabel!

    // MARK: - IBAction
    @IBAction private func addToWatchlistTapped(_ sender: UIButton) {
        movieDetailsViewModel.addToWatchlist()
    }

    // MARK: - Variables
    private lazy var movieDetailsViewModel = MovieDetailsViewModel(movieDetailsRepository: MovieDetailsRepository(coreDataManager: CoreDataManager()), delegate: self)
    private lazy var imageLoader = APIImageLoader()

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsViewModel.fetchMovieDetails()
        updateUI()
    }

    func setMovieID(movieID: Int) {
        movieDetailsViewModel.updateMovieID(movieID: movieID)
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelType {
    func didUpdateMovieDetails() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }

    func displayError(with message: String) {
        let alert = UIAlertController(title: "Already Saved!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func updateUI() {
        titleLabel.text = movieDetailsViewModel.originalTitle
        overviewLabel?.text = movieDetailsViewModel.overview
        releaseDateLabel.text = movieDetailsViewModel.releaseDate
        runTime.text = movieDetailsViewModel.runTime.map { "\($0) mins" }
        voteAverage.text = movieDetailsViewModel.voteAverage.map { "Rating: \(String(format: "%.1f", $0)) / 10" }
        status.text = movieDetailsViewModel.status.map { "Release status: \($0)"}

        if let posterURL = movieDetailsViewModel.moviePosterURL {
            imageLoader.loadImage(from: posterURL, imageView: posterImageView)
        }
    }
}
