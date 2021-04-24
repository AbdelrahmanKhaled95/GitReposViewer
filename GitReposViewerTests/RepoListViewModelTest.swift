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
    var sut: RepositoryViewModel!
    var webServiceMock: WebServiceProtocol!
    
    override func setUp() {
        sut = RepositoryViewModel(webService: webServiceMock())
    }
}
