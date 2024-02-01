//
//  FavoritesCellViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import Foundation

final class FavoritesCellViewModel {
    // MARK: Properties
    let movie: FavoriteMovie
    
    // MARK: Init
    init(movie: FavoriteMovie) {
        self.movie = movie
    }
    
    // MARK: Methods
    var moviePosterData: Data? {
        movie.posterImageData
    }
    
    var movieTitle: String {
        movie.title ?? ""
    }
    
    var movieGenres: String {
        (movie.genres as! [String]).joined(separator: ", ")
    }
    
    var releaseDateText: String {
        guard let date = movie.releaseDate else { return "" }
        let year = String(date.prefix(4))
        return "Released in \(year)"
    }
}
