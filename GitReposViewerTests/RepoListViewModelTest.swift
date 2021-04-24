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

        guard let bundle = Bundle.unitTest.path(forResource: "RepositoryStub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        
        sut.getRequestArray(url: URL(fileURLWithPath: bundle), responseType: RepositoryModel.self) { (reposList, error) in
            responseError = error
            responseModel = reposList
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseModel)
    }
    
    func test_fetch_repoDetail() {
        let promise = XCTestExpectation(description: "Fetch repository detail")
        var responseError: Error?
        var responseModel: RepositoryDetailsModel?

        guard let bundle = Bundle.unitTest.path(forResource: "RepositryDetailStub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.getRequest(url: URL(fileURLWithPath: bundle), responseType: RepositoryDetailsModel.self) { (repo, error) in
            responseError = error
            responseModel = repo
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseModel)
    }
}
