//
//  NowPlaying-ViewModel.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/08.
//

import Foundation

protocol NowPlayingViewModelDelegate: AnyObject {
    func reloadView()
}

class NowPlayingViewModel {

    // MARK: - Variables
    var nowPlayingMovies: [NowPlayingResults]?
    private let nowPlayingRepository: NowPlayingRepositoryType?
    private weak var delegate: NowPlayingViewModelDelegate?

    // MARK: - Initializer
    init(nowPlayingRepository: NowPlayingRepositoryType, delegate: NowPlayingViewModelDelegate) {
        self.nowPlayingRepository = nowPlayingRepository
        self.nowPlayingMovies = []
        self.delegate = delegate
    }

    // MARK: - Function
    func fetchNowPlayingMovies() {
        nowPlayingRepository?.fetchMovies { [weak self] result in
            switch result {
            case .success(let nowPlaying):
                self?.nowPlayingMovies = nowPlaying.results ?? []
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
