//
//  GitHubErrorMessage.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation
class GitHubErrorMessage: NSObject, Decodable, LocalizedError {
    let message: String
    
    override var description: String {
        get {
            return message
        }
    }
    var errorDescription: String? {
        get {
            return self.description
        }
    }
}
