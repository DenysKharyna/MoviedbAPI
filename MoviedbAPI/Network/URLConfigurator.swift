//
//  HttpRequest.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

struct URLConfigurator {
    private init() {}
    
    static private func getBaseComponents(host: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.queryItems = [URLQueryItem(name: "api_key", value: NetworkConstants.apiKey)]
        
        return components
    }
    
    static func topRatedMoviesURL() -> URL? {
        var components = getBaseComponents(host: NetworkConstants.moviesHost)
        components.path = NetworkEndpoints.topRated.path
        
        return components.url
    }
    
    static func movieDetailsURL(movieID id: Int) -> URL? {
        var components = getBaseComponents(host: NetworkConstants.moviesHost)
        components.path = NetworkEndpoints.movie(id: id).path
        
        return components.url
    }
    
    static func moviePosterURL(posterPath: String) -> URL? {
        var components = getBaseComponents(host: NetworkConstants.moviePosterHost)
        components.path = NetworkEndpoints.moviePoster(posterPath: posterPath).path
        
        return components.url
    }
}
