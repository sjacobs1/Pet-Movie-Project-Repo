//
//  NewTableViewCell.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit
import SDWebImage

class NewTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var newCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newCollectionView.dataSource = self
        newCollectionView.delegate = self

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 148)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        newCollectionView.collectionViewLayout = layout

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as? PosterCellCollectionViewCell else {
            fatalError("Unable to dequeue PosterCellCollectionViewCell.")
        }
        return cell
    }
}
