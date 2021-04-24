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
    case getCreationDate(String, String)
    case getBranches(String, String)
    case getForks(String, String)
    case getContributors(String, String)
    
    // Concatenate base url with endpoints
    private var path: String {
        switch self {
        case .getRepos:
            return WebRouter.baseURL + "repositories"
        case .getCreationDate(let owner, let repositoryName):
            return WebRouter.baseURL + "repos/\(owner)/\(repositoryName)"
        case .getBranches(let owner, let repositoryName):
            return WebRouter.baseURL + "repos/\(owner)/\(repositoryName)/branches"
        case .getForks(let owner, let repositoryName):
            return WebRouter.baseURL + "repos/\(owner)/\(repositoryName)/forks"
        case .getContributors(let owner, let repositoryName):
            return WebRouter.baseURL + "repos/\(owner)/\(repositoryName)/contributors"
        }
    }
    // Convert url string to URL
    var url: URL {
        guard let urlValue = URL(string: path) else { fatalError() }
        return urlValue
    }
}
