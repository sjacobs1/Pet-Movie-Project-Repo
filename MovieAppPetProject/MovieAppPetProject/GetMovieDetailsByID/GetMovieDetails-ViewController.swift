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

    // MARK: - Variables
    var viewModel = MovieDetailsViewModel()
    private var selectedSearchMovie: SearchMoviesResults?
    private var selectedHomeScreenMovies: NowPlayingResults?

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.displayMovieDetails { [weak self] title, posterPath in
            self?.titleLabel.text = title
            if let posterPath = posterPath {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                self?.posterImageView.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "Me"))
            }
        }
    }
}
