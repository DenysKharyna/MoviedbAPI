//
//  MoviesListViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

protocol ReloadCollectionViewDelegate: AnyObject {
    func reloadCollectionView()
}

final class MoviesListViewModel {
    // MARK: Properties
    private let networkManager: NetworkManager
    weak var delegate: ReloadCollectionViewDelegate?
    
    var moviesList: [Movie] = []
    
    var numberOfCells: Int {
        moviesList.count
    }
    
    // MARK: Init
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: Methods
    func getTopRatedMovies() {
        networkManager.getTopRatedMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.moviesList = movies
                self?.delegate?.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
        
    func cellSize(collectionViewWidth: CGFloat) -> CGSize {
        let width = (collectionViewWidth - 56) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
