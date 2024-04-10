//
//  SearchMovies-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import UIKit

class SearchMoviesViewController: UIViewController {
    private let searchMoviesViewModel = SearchMoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchMoviesViewModel.fetchSearchedMovies()
    }
}
