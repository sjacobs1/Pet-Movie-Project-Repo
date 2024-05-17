//
//  ImageLoader.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/17.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL, imageView: UIImageView)
}

class APIImageLoader: ImageLoaderProtocol {
    func loadImage(from url: URL, imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}
