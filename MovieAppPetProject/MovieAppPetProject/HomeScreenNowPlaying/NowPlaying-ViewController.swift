//
//  ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/02.
//

import UIKit

class NowPlayingViewController: UIViewController {
    private let nowPlayingViewModel = NowPlayingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingViewModel.fetchMovies()
    }
}
