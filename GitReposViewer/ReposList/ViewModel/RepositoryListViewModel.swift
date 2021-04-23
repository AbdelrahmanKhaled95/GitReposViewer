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
    }
    //Step 2: Loop over each repo
    func getEachRepoInfo() {
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
            if repository.name.contains(searchValue) {
                searchRepoList.append(repository)
            }
        }
        self.allReposList = searchRepoList
    }
}
