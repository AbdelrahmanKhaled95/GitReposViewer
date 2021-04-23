//
//  RepositoryListViewModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class RepositoryViewModel {
    
    let webService: WebServiceProtocol
    var allReposList: [RepositoryModel] = []
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func fetchGitHubRepositories() {
        webService.getRequest(url: WebRouter.getRepos.url, responseType: RepositoryModel.self) { [weak self] (RepoList, error) in
            guard let self = self else { return }
            print(RepoList)
            if let RepoList = RepoList {
                self.allReposList = RepoList
            }
            
        }
    }
    //MARK:- RepositoryList Filteration
    //Step 1: Ensure that each repository is public and not private
    func getPublicReposOnly(reposList: [RepositoryModel]){
        var publicRepositoryList: [RepositoryModel] = []
        for repository in reposList {
            if repository.repositoryPrivate == false {
                publicRepositoryList.append(repository)
            }
        }
        getCreationDate(publicReposList: publicRepositoryList)
    }

}
