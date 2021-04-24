//
//  StubGenerator.swift
//  GitReposViewerTests
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation
@testable import GitReposViewer

class StubGenerator {
    func stubRepositories() -> [RepositoryModel] {
        let path = Bundle.unitTest.path(forResource: "stub", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let repoList = try! decoder.decode([RepositoryModel].self, from: data)
        return repoList
    }
}
