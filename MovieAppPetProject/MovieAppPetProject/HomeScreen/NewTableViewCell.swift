//
//  NewTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit

class NewTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet private weak var sectionTitleLabel: UILabel!
    @IBOutlet private weak var newCollectionView: UICollectionView!

    // MARK: - Variables
    var didSelectItem: ((Movie) -> Void)?
    private var movies: [Movie] = []

    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        newCollectionView.dataSource = self
        newCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 105, height: 195)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        newCollectionView.collectionViewLayout = layout
    }

    func configure(with movies: [Movie], sectionTitle: String) {
        self.movies = movies
        sectionTitleLabel?.text = sectionTitle
        newCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.homeScreenCollectionViewCell, for: indexPath) as? PosterCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.item]
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
        let selectedMovie = movies[indexPath.item]
        didSelectItem?(selectedMovie)
    }
}
