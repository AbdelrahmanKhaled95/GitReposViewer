//
//  WebServiceMock.swift
//  GitReposViewerTests
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation
@testable import GitReposViewer

class WebServiceMock<ResponseType: Decodable>: WebServiceProtocol {
    
    //MARK:- Properties
    var fetchReposCalled: Bool = false
    var fetchRepoDetailsCalled: Bool = false
    var fetchBranchCalled: Bool = false
    var fetchContributorsCalled: Bool = false
    var fetchForkCalled: Bool = false
    
    var repositoryList: [RepositoryModel] = []
    var repositoryDate: RepositoryDetailsModel!
    var repositoryBranchList: [BranchModel] = []
    var repositoryContributorList: [ContributorModel] = []
    var repositoryForkList: [ForkModel] = []
    
    var repositoryMockCompleteHandler: (([RepositoryModel]?, Error?) -> ())!
    var repositoryDateMockCompleteHandler: ((ResponseType?, Error?) -> Void)!
    var branchMockCompleteHandler: (([BranchModel]?, Error?) -> ())!
    var contributorMockCompleteHandler: (([ContributorModel]?, Error?) -> ())!
    var forkMockCompleteHandler: (([ForkModel]?, Error?) -> ())!
    
    
    func getRequestArray<ResponseType>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping ([ResponseType]?, Error?) -> Void) where ResponseType : Decodable {
        fetchForkCalled = true
        fetchReposCalled = true
        fetchBranchCalled = true
        fetchContributorsCalled = true
    }
    
    func getRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?) -> Void) {
        fetchRepoDetailsCalled = true
        repositoryDateMockCompleteHandler = completionHandler
    }

}
