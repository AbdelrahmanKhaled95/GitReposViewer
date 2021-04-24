//
//  RepoListViewModelTest.swift
//  GitReposViewerTests
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import XCTest
@testable import GitReposViewer


class RepoListViewModelTests: XCTestCase {
    //MARK:- Properties
    var sut: WebSerice!

    override func setUp() {
        super.setUp()
        sut = WebSerice()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetch_repos() {

        let promise = XCTestExpectation(description: "Fetch repository list")
        var responseError: Error?
        var responseModel: [RepositoryModel]?

        // When
        guard let bundle = Bundle.unitTest.path(forResource: "RepositoryStub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        
        sut.getRequestArray(url: URL(fileURLWithPath: bundle), responseType: RepositoryModel.self) { (reposList, error) in
            <#code#>
        }
        
        
        
        initalFetchGitHubRepositories( fetchPhotos(from: URL(fileURLWithPath: bundle), complete: { (photos, error) in
            responseError = error
            responsePhotos = photos
            promise.fulfill()
        })
        wait(for: [promise], timeout: 1)

        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responsePhotos)
    }
}
