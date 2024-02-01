//
//  CoreDataManager.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case fetchError
}

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchFavoriteMovies(completion: (Result<[FavoriteMovie], CoreDataError>) -> Void) {
        do {
            let movies = try context.fetch(FavoriteMovie.fetchRequest())
            completion(.success(movies))
        } catch {
            completion(.failure(.fetchError))
        }
    }
    
    func saveFavoriteMovie(movieDetails: MovieDetails) {
        let favoriteMovie = FavoriteMovie(context: context)
        favoriteMovie.title = movieDetails.title
        favoriteMovie.releaseDate = movieDetails.releaseDate
        guard let data = UIImage().jpegData(compressionQuality: 0.5) else { return }
        favoriteMovie.posterImageData = data
        favoriteMovie.genres = movieDetails.genres.map({$0.name}) as NSObject
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
