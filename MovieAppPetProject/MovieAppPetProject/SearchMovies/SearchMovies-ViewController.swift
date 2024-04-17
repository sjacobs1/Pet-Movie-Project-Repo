//
//  SearchMovies-ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/10.
//

import UIKit
import SDWebImage

class SearchMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let searchMoviesViewModel = SearchMoviesViewModel()
    
    
    @IBOutlet weak var searchMovieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SearchMovieTableViewCell", bundle: nil)
        searchMovieTableView.register(nib, forCellReuseIdentifier: "reuseCell")
        searchMovieTableView.dataSource = self
        searchMovieTableView.delegate = self
        searchMoviesViewModel.fetchSearchedMovies(completion: { [weak self] result in
            // Handle result
            DispatchQueue.main.async {
                self?.searchMovieTableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("vase:\(searchMoviesViewModel.searchedMovies.count)")
        
        return searchMoviesViewModel.searchedMovies.count
//        - Int(searchMoviesViewModel.searchedMovies.count/2)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? SearchMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = searchMoviesViewModel.searchedMovies[indexPath.row]
        let title = movie.originalTitle
        if let posterPath = movie.moviePoster {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.configure(with: posterURL, placeholderImage: UIImage(named: "Me"), title: title)
        } else {
            cell.configure(with: nil, placeholderImage: UIImage(named: "Me"), title: title)
            
        }
        
        return cell
    }
}
