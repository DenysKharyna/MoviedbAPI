//
//  NetworkErrors.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 02.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case sessionError
    case parsingError
    
    var description: String {
        switch self {
        case .invalidURL:
            "Invalid URL to the resource."
        case .invalidData:
            "Invalid data."
        case .sessionError, .parsingError:
            "Sorry, there is appeared a problem while fetching movies."
        }
    }
}

enum DownloadingImageError: Error {
    case invalidURL
    case invalidData
    
    var description: String {
        switch self {
        case .invalidURL:
            "Invalid URL to the image."
        case .invalidData:
            "Sorry, there is appeared a problem while downloading movie image."
        }
    }
}
