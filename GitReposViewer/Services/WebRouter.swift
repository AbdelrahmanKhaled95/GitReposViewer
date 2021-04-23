//
//  WebRouter.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

enum WebRouter {
    //MARK:- Base URL
    private static let baseURL = "https://api.github.com/"
    //MARK:- Endpoints
    case getRepos
    
    // Concatenate base url with endpoints
    private var path: String {
        switch self {
        case .getRepos:
            return WebRouter.baseURL + "repositories"
        }
    }
    // Convert url string to URL
    var url: URL {
        guard let urlValue = URL(string: path) else { fatalError() }
        return urlValue
    }
}
