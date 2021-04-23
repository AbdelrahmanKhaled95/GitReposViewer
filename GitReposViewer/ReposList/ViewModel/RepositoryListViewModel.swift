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
        webService.getRequestArray(url: WebRouter.getRepos.url, responseType: RepositoryModel.self) { [weak self] (result, error) in
            guard let self = self else { return }
            
            if let RepoList = result {
                self.getPublicReposOnly(reposList: RepoList)
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
        getRepoCreationDate(publicReposList: publicRepositoryList)
    }
    
    //Step2: Get each repo's Creation date
    func getRepoCreationDate(publicReposList repositories: [RepositoryModel]) {
        repositories.forEach { (repository) in
            webService.getRequest(url: WebRouter.getCreationDate(repository.owner.login, repository.name).url, responseType: RepositoryDetailsModel.self) { (date, error) in
                let dateString = date?.createdAt.toDate()
                
                print(dateString?.toString())
            }
        }
        
    }
    
}
