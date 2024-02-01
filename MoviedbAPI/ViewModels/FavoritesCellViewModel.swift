//
//  FavoritesCellViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import Foundation

final class FavoritesCellViewModel {
    // MARK: Properties
    let movie: Movie
    
    // MARK: Init
    init(movie: Movie) {
        self.movie = movie
    }
}
