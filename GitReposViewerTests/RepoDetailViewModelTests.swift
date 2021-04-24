//
//  RepoDetailViewModelTests.swift
//  GitReposViewerTests
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation
import XCTest
@testable import GitReposViewer

class RepoDetailViewModelTest: XCTestCase {
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
    
    func test_fetch_Branch() {
        let promise = XCTestExpectation(description: "Fetch repository Branches")
        var responseError: Error?
        var responseModel: [BranchModel]?

        guard let bundle = Bundle.unitTest.path(forResource: "BranchStub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.getRequestArray(url: URL(fileURLWithPath: bundle), responseType: BranchModel.self) { (branch, error) in
            responseError = error
            responseModel = branch
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseModel)
    }
    
    func test_fetch_Fork() {
        let promise = XCTestExpectation(description: "Fetch repository Branches")
        var responseError: Error?
        var responseModel: [ForkModel]?

        guard let bundle = Bundle.unitTest.path(forResource: "ForkStub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.getRequest(url: URL(fileURLWithPath: bundle), responseType: [ForkModel].self) { (fork, error) in
            responseError = error
            responseModel = fork
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseModel)
    }
    
    func test_fetch_Contributor() {
        let promise = XCTestExpectation(description: "Fetch repository Branches")
        var responseError: Error?
        var responseModel: [ContributorModel]?

        guard let bundle = Bundle.unitTest.path(forResource: "ContributorStub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.getRequest(url: URL(fileURLWithPath: bundle), responseType: [ContributorModel].self) { (contributor, error) in
            responseError = error
            responseModel = contributor
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseModel)
    }
    
}
