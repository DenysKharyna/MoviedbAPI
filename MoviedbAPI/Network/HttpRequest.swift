//
//  HttpRequest.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct HttpRequest {
    private init() {}
    
    static func configureRequest(url: URL, method: HTTPMethod, headers: [String:String]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}
