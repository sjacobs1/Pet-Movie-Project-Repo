//
//  ViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/02.
//

import UIKit
import SDWebImage

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!

    private let nowPlayingViewModel = NowPlayingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 20, right: 10)
        nowPlayingCollectionView.collectionViewLayout = layout

        fetchNowPlayingMovies()
    }

    func fetchNowPlayingMovies() {
        nowPlayingViewModel.fetchNowPlayingMovies { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.nowPlayingCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching now playing movies: \(error)")
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingViewModel.nowPlayingMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as? PosterCellCollectionViewCell else {
            fatalError("Unable to dequeue PosterCellCollectionViewCell.")
        }

        let movie = nowPlayingViewModel.nowPlayingMovies[indexPath.item]
        if let posterPath = movie.moviePoster {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.posterCover.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.posterCover.image = UIImage(named: "placeholder")
        }

        return cell
    }

}
