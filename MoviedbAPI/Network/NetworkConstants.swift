//
//  NetworkEndpoints.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

struct NetworkConstants {
    private init() {}
    
    static let moviesHost = "api.themoviedb.org"
    static let moviePosterHost = "image.tmdb.org"
    static let apiKey = "2ccc9fcb3e886fcb5f80015418735095"
}

enum NetworkEndpoints {
    case topRated
    case movie(id: Int)
    case moviePoster(posterPath: String)
    
    var path: String {
        switch self {
        case .topRated:
            return "/3/movie/top_rated"
        case .movie(let id):
            return "/3/movie" + "/\(id)"
        case .moviePoster(let posterPath):
            return "/t/p/w500" + "/\(posterPath)"
        }
    }
}
