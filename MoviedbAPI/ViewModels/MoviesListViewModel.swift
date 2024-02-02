//
//  MoviesListViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import UIKit

protocol ErrorPresenter: AnyObject {
    func presentError(message: String)
}

protocol MovieListDelegate: ErrorPresenter  {
    func reloadCollectionView()
}

final class MoviesListViewModel {
    // MARK: Properties
    let networkManager: NetworkManager
    let coreDataManager = CoreDataManager()
    weak var delegate: MovieListDelegate?
    
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
                self?.delegate?.presentError(message: error.description)
            }
        }
    }
    
    func addMovieToFavorites(movie: Movie, moviePoster: UIImage) {
        if !coreDataManager.isInFavorites(context: context, movie: movie) {
            saveMovieToCoreData(movieID: movie.id, moviePoster: moviePoster)
        } else {
            delegate?.presentError(message: CoreDataError.alreadyInFavorites.description)
        }
    }
    
    private func saveMovieToCoreData(movieID id: Int, moviePoster: UIImage) {
        networkManager.getMovieDetails(movieID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.coreDataManager.saveFavoriteMovie(context: self.context, movieDetails: details, moviePoster: moviePoster)
            case .failure(let error):
                self.delegate?.presentError(message: error.description)
            }
        }
    }
        
    func cellSize(collectionViewWidth: CGFloat) -> CGSize {
        let width = (collectionViewWidth - 56) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
