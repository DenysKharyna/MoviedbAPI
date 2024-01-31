//
//  NetworkManager.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case sessionError
    case parsingError
}

final class NetworkManager {
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
                print(error.localizedDescription)
                completion(.failure(.parsingError))
            }
            
        }.resume()
    }
}
