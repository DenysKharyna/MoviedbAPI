//
//  MovieDetailsViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

final class MovieDetailsViewModel {
    // MARK: Properties
    let movie: Movie
    
    var getMovieReleaseYear: String {
        String(movie.releaseDate.prefix(4))
    }
    
    // MARK: Init
    init(movie: Movie) {
        self.movie = movie
    }
}
