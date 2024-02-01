//
//  MovieDetailsViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

final class MovieDetailsViewModel {
    // MARK: Properties
    let networkManager: NetworkManager
    
    let movie: Movie
    
    var movieTitle: String {
        movie.title
    }
    
    var moviePosterPath: String {
        movie.posterPath
    }
    
    var movieDescription: String {
        movie.overview
    }
    
    var movieReleaseYear: String {
        String(movie.releaseDate.prefix(4))
    }
    
    // MARK: Init
    init(movie: Movie, networkManager: NetworkManager) {
        self.movie = movie
        self.networkManager = networkManager
    }
}
