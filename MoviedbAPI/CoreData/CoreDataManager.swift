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
    case saveError
    case deleteError
}

final class CoreDataManager {
    func fetchFavoriteMovies(context: NSManagedObjectContext, completion: (Result<[FavoriteMovie], CoreDataError>) -> Void) {
        do {
            let movies = try context.fetch(FavoriteMovie.fetchRequest())
            completion(.success(movies))
        } catch {
            completion(.failure(.fetchError))
        }
    }
    
    func saveFavoriteMovie(context: NSManagedObjectContext, movieDetails: MovieDetails, moviePoster: UIImage) {
        let favoriteMovie = FavoriteMovie(context: context)
        favoriteMovie.title = movieDetails.title
        favoriteMovie.releaseDate = movieDetails.releaseDate
        guard let data = moviePoster.jpegData(compressionQuality: 0.5) else { return }
        favoriteMovie.posterImageData = data
        favoriteMovie.genres = movieDetails.genres.map({$0.name}) as NSObject
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteFavoriteMovie(context: NSManagedObjectContext, movie: FavoriteMovie) {
        context.delete(movie)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
