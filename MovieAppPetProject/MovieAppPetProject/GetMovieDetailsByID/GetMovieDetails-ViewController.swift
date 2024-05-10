//
//  GetMovieDetails-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!

    // MARK: - Variables
    var movieID: Int?
    private lazy var movieDetailsViewModel = MovieDetailsViewModel(movieID: movieID ?? 0, movieDetailsRepository: MovieDetailsRepository())

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        movieDetailsViewModel.fetchMovieDetails()
        setupViewModelObserver()
    }

    private func setupViewModelObserver() {
        movieDetailsViewModel.didUpdateDetails = { [weak self] in
            self?.updateUI()
        }
    }

    private func updateUI() {
        titleLabel.text = movieDetailsViewModel.originalTitle
        overviewLabel.text = movieDetailsViewModel.overview
        releaseDateLabel.text = movieDetailsViewModel.releaseDate
        if let posterURL = movieDetailsViewModel.moviePosterURL {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
