//
//  NetworkManager.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case sessionError
    case parsingError
}

final class NetworkManager {
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: Method for fetching top rated movies
    func getTopRatedMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let url = URLConfigurator.topRatedMoviesURL() else {
            completion(.failure(.invalidURL))
            return
        }
        
        let headers = ["accept": "application/json"]
        let request = HttpRequest.configureRequest(url: url, method: .get, headers: headers)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.sessionError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(.parsingError))
            }
            
        }.resume()
    }
    
    // MARK: Method for downloading movie poster image
    func downloadMovieImage(posterPath path: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let cacheKey = NSString(string: path)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
            return
        }
        
        guard let url = URLConfigurator.moviePosterURL(posterPath: path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(.success(image))
        }.resume()
    }
    
    // MARK: Method for fetching movie details
    func getMovieDetails(movieID id: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        guard let url = URLConfigurator.movieDetailsURL(movieID: id) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let headers = ["accept": "application/json"]
        let request = HttpRequest.configureRequest(url: url, method: .get, headers: headers)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.sessionError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                completion(.success(movieDetails))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.parsingError))
            }
        }.resume()
    }
}
