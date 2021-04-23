//
//  RepositoryListViewModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 23/04/2021.
//

import Foundation

class RepositoryViewModel {
    
    //MARK:- Properties
    let webService: WebServiceProtocol
    private var allReposList: [RepositoryModel] = []
    var selectedGitRepo: RepositoryModel?
    private var repoListCellViewModels: [RepoListCellViewModel] = [RepoListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    var numberOfCells: Int {
        return repoListCellViewModels.count
    }
    
    init(webService: WebServiceProtocol = WebSerice()) {
        self.webService = webService
    }
    
    //MARK:- Binding Closures
    var reloadTableView: (()->())?
    var state: ViewState = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var updateLoadingStatus: (()->())?
    var errorMessage: String? {
        didSet {
            self.showAlert?()
        }
    }
    var showAlert: (()->())?
    
    func initalFetchGitHubRepositories() {
        state = .loading
        webService.getRequestArray(url: WebRouter.getRepos.url, responseType: RepositoryModel.self) { [weak self] (result, error) in
            guard let self = self else { return }
            guard let RepoList = result else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            self.state = .filled
            self.getPublicReposOnly(reposList: RepoList)
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
        }
    }
    
    //Step 2: Get each repo's Creation date
    func getRepoCreationDate(repository: RepositoryModel) {
        webService.getRequest(url: WebRouter.getCreationDate(repository.owner.login, repository.name).url, responseType: RepositoryDetailsModel.self) { [weak self] (date, error) in
            guard let self = self else { return }
            guard let date = date else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            if let dateString = date.createdAt.toDate() {
                print(dateString.toString())
            }
        }
    }
    //Step 3: 
}
//MARK:- Repo Filteration
extension RepositoryViewModel {
    
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
