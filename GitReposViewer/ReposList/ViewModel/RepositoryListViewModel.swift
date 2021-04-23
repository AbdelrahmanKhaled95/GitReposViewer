//
//  RepositoryListViewModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class RepositoryViewModel {
    
    let webService: WebServiceProtocol
    private var allReposList: [RepositoryModel] = []
    
    init(webService: WebServiceProtocol = WebSerice()) {
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
        self.allReposList = publicRepositoryList
        publicRepositoryList.forEach { (repository) in
            getRepoCreationDate(repository: repository)
            getOwnerAvatar(avatar: repository.owner.avatarURL)
        }
    }
    
    //Step 2: Get each repo's Creation date
    func getRepoCreationDate(repository: RepositoryModel) {
        webService.getRequest(url: WebRouter.getCreationDate(repository.owner.login, repository.name).url, responseType: RepositoryDetailsModel.self) { (date, error) in
            guard let date = date else {
                print(error?.localizedDescription)
                return
            }
            if let dateString = date.createdAt.toDate() {
                print(dateString.toString())
            }
        }
    }
    // Step 3: Get Owner's Avatar
    func getOwnerAvatar(avatar imageURLString: String) {
        webService.loadImages(urlString: imageURLString) { (image, error) in
            print(image)
        }
    }
}
//MARK:- Search
extension RepositoryViewModel {
    func serachForRepo(searchValue: String) {
        var searchRepoList: [RepositoryModel] = []
        allReposList.forEach { (repository) in
            if repository.name.contains(searchValue) {
                searchRepoList.append(repository)
            }
        }
        self.allReposList = searchRepoList
    }
}
