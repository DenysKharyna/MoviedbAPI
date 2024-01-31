//
//  UIImage+Extension.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import UIKit

extension UIImageView {
    func setPosterImage(posterPath path: String, networkManager: NetworkManager) {
        networkManager.downloadMovieImage(posterPath: path) { [weak self] result in
            switch result {
            case .success(let posterImage):
                DispatchQueue.main.async {
                    self?.image = posterImage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
