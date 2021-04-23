//
//  RepositoryListViewModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class RepositoryViewModel {
    
    let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func fetchGitHubRepositories() {
        webService.getRequest(url: WebRouter.getRepos.url, responseType: RepositoryModel.self) { (RepoList, error) in
            print(RepoList)
        }
    }
}
