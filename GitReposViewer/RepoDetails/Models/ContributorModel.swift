//
//  ContributorModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

// MARK: - ContributorModel
struct ContributorModel: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}


