//
//  MoviesListViewModel.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

final class MoviesListViewModel {
    private let networkManager: NetworkManager!
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTopRatedMovies() {
        networkManager.getTopRatedMovies { result in
            switch result {
            case .success(let movies):
                print(movies.count)
            case .failure(let error):
                print(error)
            }
        }
    }
}
