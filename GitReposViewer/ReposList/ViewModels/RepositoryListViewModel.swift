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
    private var allReposCreationDate: [String] = []
    var contributorsURL, forksURL, branchesURL : String?
    var repoListCellViewModels: [RepoListCellViewModel] = [RepoListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
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
            guard let repoList = result else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            self.state = .filled
            self.getPublicReposOnly(reposList: repoList)
        }
    }
}
//MARK:- Repo Filteration
extension RepositoryViewModel {
    //Step 1: Ensure that each repository is public and not private
    func getPublicReposOnly(reposList: [RepositoryModel]){
        var publicRepositoryList: [RepositoryModel] = []
        for repository in reposList {
            if repository.repositoryPrivate == false {
                publicRepositoryList.append(repository)
            }
        }
        self.allReposList = publicRepositoryList
        self.getEachRepoInfo()
    }
    //Step 2: Loop over each repo
    func getEachRepoInfo() {
        self.allReposCreationDate.removeAll()
        self.allReposList.forEach { (repository) in
            getRepoCreationDate(repository: repository)
        }
    }
    
    //Step 3: Get each repo's Creation date
    func getRepoCreationDate(repository: RepositoryModel) {
        webService.getRequest(url: WebRouter.getCreationDate(repository.owner.login, repository.name).url, responseType: RepositoryDetailsModel.self) { [weak self] (date, error) in
            guard let self = self else { return }
            guard let date = date, let dateString = date.createdAt.toDate()  else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            self.allReposCreationDate.append(dateString.toString())
            if self.allReposCreationDate.count == self.allReposList.count {
                self.generateCellViewModelList()
            }
        }
    }
    //Step 4: Generate cell View model
    func generateCellViewModel(repository: RepositoryModel, date: String) -> RepoListCellViewModel {
        return RepoListCellViewModel(repositoryName: repository.name, ownerAvatar: repository.owner.avatarURL, ownerName: repository.owner.login, creationDate: date)
    }
    //Step 5: Generate cell View model array
    func generateCellViewModelList() {
        var repoCellViewModelList: [RepoListCellViewModel] = []
        for (index, repository) in allReposList.enumerated() {
            repoCellViewModelList.append(generateCellViewModel(repository: repository, date: allReposCreationDate[index]))
        }
        self.repoListCellViewModels = repoCellViewModelList
    }
}

//MARK:- Search
extension RepositoryViewModel {
    func serachForRepo(searchValue: String) {
        var searchRepoList: [RepositoryModel] = []
        allReposList.forEach { (repository) in
            if repository.name.contains(searchValue.lowercased()) {
                searchRepoList.append(repository)
            }
        }
        if searchRepoList.count == 0 {
            self.repoListCellViewModels = []
        }
        self.allReposList = searchRepoList
        
        self.getEachRepoInfo()
    }
}
//MARK:- Transfer data to second screen
extension RepositoryViewModel {
    func selectedRepo(index: Int){
        let repository = self.allReposList[index]
        self.contributorsURL = repository.contributorsURL
        self.forksURL = repository.forksURL
        self.branchesURL = repository.branchesURL
    }
}
