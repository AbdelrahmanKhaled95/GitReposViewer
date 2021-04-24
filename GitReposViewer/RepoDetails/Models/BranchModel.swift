//
//  BranchModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

// MARK: - BranchModelElement
struct BranchModel: Codable {
    let name: String
    let commit: Commit
    let protected: Bool
}

// MARK: - Commit
struct Commit: Codable {
    let sha: String
    let url: String
}
