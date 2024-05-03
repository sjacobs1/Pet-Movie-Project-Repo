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

    // MARK: - Variables
    private var selectedSearchMovie: SearchMoviesResults?
    private var selectedHomeScreenMovies: NowPlayingResults?
    private lazy var movieDetailsViewModel = MovieDetailsViewModel(movieDetails: nil, selectedSearchMovie: nil, selectedHomeScreenMovies: nil, movieDetailsRepository: MovieDetailsRepository())

    // MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsViewModel.displayMovieDetails { [weak self] title, posterPath in #warning("WIP: Will refactor this at a later stage with navigation functionality")
            self?.titleLabel.text = title
            if let posterPath = posterPath {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                self?.posterImageView.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "Me"))
            }
        }
    }
}
