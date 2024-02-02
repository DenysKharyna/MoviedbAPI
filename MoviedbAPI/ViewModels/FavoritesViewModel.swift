//
//  FavoritesViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import UIKit

final class FavoritesViewModel {
    // MARK: Properties
    let coreDataManager: CoreDataManager
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var delegate: ErrorPresenter?
    
    var favoriteMovies: [FavoriteMovie] = []
    
    var numberOfCells: Int {
        favoriteMovies.count
    }
    
    // MARK: Init
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: Methods
    func fetchFavoriteMovies() {
        coreDataManager.fetchFavoriteMovies(context: context) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.favoriteMovies = movies
            case .failure(let error):
                self?.delegate?.presentError(message: error.description)
            }
        }
    }
    
    func deleteFavoriteMovie(at index: Int) {
        coreDataManager.deleteFavoriteMovie(context: context, movie: favoriteMovies[index])
        favoriteMovies.remove(at: index)
    }
}
