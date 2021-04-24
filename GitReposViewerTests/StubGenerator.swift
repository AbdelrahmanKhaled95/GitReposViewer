//
//  StubGenerator.swift
//  GitReposViewerTests
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation
@testable import GitReposViewer

class StubGenerator {
    func stubPhotos() -> [Photo]? {
        guard let path = Bundle.unitTest.path(forResource: "stub", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let photos = try? decoder.decode(Photos.self, from: data)
        return photos?.photos
    }
}
