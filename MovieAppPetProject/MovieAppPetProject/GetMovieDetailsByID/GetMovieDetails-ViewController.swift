//
//  GetMovieDetails-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private var selectedSearchMovie: SearchMoviesResults?
    private var selectedHomeScreenMovies: NowPlayingResults?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMovieDetails()
    }
    
    func setMovieDetails(selectedSearchMovie: SearchMoviesResults? = nil, selectedHomeScreenMovies: NowPlayingResults? = nil) {
        self.selectedSearchMovie = selectedSearchMovie
        self.selectedHomeScreenMovies = selectedHomeScreenMovies
    }
    
    func displayMovieDetails() {
        if let nowPlayingMovie = selectedHomeScreenMovies {
            titleLabel.text = nowPlayingMovie.originalTitle
            if let posterPath = nowPlayingMovie.moviePoster {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                posterImageView.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "Me"))
            }
        } else if let searchMovie = selectedSearchMovie {
            titleLabel.text = searchMovie.originalTitle
            if let posterPath = searchMovie.moviePoster {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                posterImageView.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "Me"))
            }
        }
    }
}
