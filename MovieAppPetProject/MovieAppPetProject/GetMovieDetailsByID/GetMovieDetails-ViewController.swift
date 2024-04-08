//
//  GetMovieDetails-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private let movieDetailsViewModel = MovieDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsViewModel.fetchMovieDetails()
    }
}
