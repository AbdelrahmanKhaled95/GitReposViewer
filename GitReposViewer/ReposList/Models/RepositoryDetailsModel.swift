//
//  RepositoryDetails.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

// MARK: - RepositoryDetailsModel
struct RepositoryDetailsModel: Decodable {
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
}
