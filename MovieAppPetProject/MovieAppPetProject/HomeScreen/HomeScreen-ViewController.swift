//
//  ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/02.
//

import UIKit

class HomeScreenViewController: UIViewController {
    private let nowPlayingViewModel = NowPlayingViewModel()
    private let popularMoviesViewModel = PopularMoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingViewModel.fetchMovies()
        popularMoviesViewModel.fetchMovies()
    }
}
