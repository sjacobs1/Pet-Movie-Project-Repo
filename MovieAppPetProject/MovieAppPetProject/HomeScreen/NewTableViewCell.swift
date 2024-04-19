//
//  NewTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit
import SDWebImage

class NewTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var nowPlayingMovies: [NowPlayingResults] = []
    weak var parentViewController: UIViewController?

    @IBOutlet weak var newCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        newCollectionView.dataSource = self
        newCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 78, height: 128)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        newCollectionView.collectionViewLayout = layout
    }

    func configure(with movies: [NowPlayingResults]) {
        nowPlayingMovies = movies
        newCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("tester: \(nowPlayingMovies.count)")
        return nowPlayingMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as? PosterCellCollectionViewCell else {
            fatalError("Unable to dequeue PosterCellCollectionViewCell.")
        }
        let movie = nowPlayingMovies[indexPath.item]
        let title = movie.originalTitle
        if let posterPath = movie.moviePoster {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.configure(with: posterURL, placeholderImage: UIImage(named: "Photo"), title: title)
        } else {
            cell.configure(with: nil, placeholderImage: UIImage(named: "Photo"), title: title)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = nowPlayingMovies[indexPath.item]
        parentViewController?.performSegue(withIdentifier: "goToMovieDetails", sender: selectedMovie)
    }
}
