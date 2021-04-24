//
//  Repositories.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

// MARK: - RepositoryModel
struct RepositoryModel: Decodable {
    let name: String
    let repositoryPrivate: Bool
    let owner: RepositoryOwnerModel
    let forksURL, contributorsURL, branchesURL : String

    
    enum CodingKeys: String, CodingKey {
        case name
        case repositoryPrivate = "private"
        case owner
        case forksURL = "forks_url"
        case branchesURL = "branches_url"
        case contributorsURL = "contributors_url"
    }
}


