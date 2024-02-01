//
//  CDMovie.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import Foundation

struct MovieDetails: Decodable {
    let title: String
    let posterPath: String
    let releaseDate: String
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
}
