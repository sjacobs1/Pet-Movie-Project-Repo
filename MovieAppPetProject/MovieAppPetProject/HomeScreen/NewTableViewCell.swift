//
//  NewTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit

class NewTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet private weak var newCollectionView: UICollectionView!

    // MARK: - Variables
    var didSelectItem: ((MovieData) -> Void)?
    private var nowPlayingMovies: [MovieData] = []

    // MARK: - Functions
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

    func configure(with movies: [MovieData], sectionTitle: String) {
        nowPlayingMovies = movies
        sectionTitleLabel?.text = sectionTitle
        newCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nowPlayingMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.homeScreenCollectionViewCell,
                                                            for: indexPath) as? PosterCellCollectionViewCell else {
            return UICollectionViewCell()
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
        didSelectItem?(selectedMovie)
    }
}
