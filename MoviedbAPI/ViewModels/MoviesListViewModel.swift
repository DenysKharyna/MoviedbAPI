//
//  MoviesListViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import UIKit

protocol ReloadCollectionViewDelegate: AnyObject {
    func reloadCollectionView()
}

final class MoviesListViewModel {
    // MARK: Properties
    let networkManager: NetworkManager
    let coreDataManager = CoreDataManager()
    weak var delegate: ReloadCollectionViewDelegate?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    func addMovieToFavorites(movie: Movie, moviePoster: UIImage) throws {
        if !coreDataManager.isInFavorites(context: context, movie: movie) {
            saveMovieToCoreData(movieID: movie.id, moviePoster: moviePoster)
        } else {
            throw CoreDataError.alreadyInFavorites
        }
    }
    
    private func saveMovieToCoreData(movieID id: Int, moviePoster: UIImage) {
        networkManager.getMovieDetails(movieID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.coreDataManager.saveFavoriteMovie(context: self.context, movieDetails: details, moviePoster: moviePoster)
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
