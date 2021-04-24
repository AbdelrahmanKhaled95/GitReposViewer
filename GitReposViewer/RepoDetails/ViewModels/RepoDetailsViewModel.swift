//
//  RepoDetailsViewModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation

class RepoDetailsViewModel {
    //MARK:- Properties
    let webService: WebServiceProtocol
    var branchListCellViewModel: [BranchesListCellViewModel] = [BranchesListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    var forkListCellViewModel: [ForkListCellViewModel]
     = [ForkListCellViewModel]() {
        didSet {
            self.reloadForkCollectionView?()
        }
    }
    var contributorListCellViewModel: [ContributorListCellViewModel]
     = [ContributorListCellViewModel]() {
        didSet {
            self.reloadContributorCollectionView?()
        }
    }

    
    init(webService: WebServiceProtocol = WebSerice()) {
        self.webService = webService
    }
    //MARK:- Binding Closures
    var reloadTableView: (()->())?
    var reloadForkCollectionView: (()->())?
    var reloadContributorCollectionView: (()->())?
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
    
    func fetchRepoBranches(ownerName: String, repositoryName: String) {
        state = .loading
        webService.getRequestArray(url: WebRouter.getBranches(ownerName, repositoryName).url, responseType: BranchModel.self) { [weak self] (result, error) in
            guard let self = self else { return }
            guard let branchList = result else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            self.state = .filled
            self.generateBranchListCellVM(branchList: branchList)
        }
    }
    
    func fetchRepoForks(ownerName: String, repositoryName: String) {
        state = .loading
        webService.getRequestArray(url: WebRouter.getForks(ownerName, repositoryName).url, responseType: ForkModel.self) { [weak self] (result, error) in
            guard let self = self else { return }
            guard let forkList = result else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            self.state = .filled
            self.generateForkListCellVM(forkList: forkList)
        }
    }
    
    func fetchRepoContributors(ownerName: String, repositoryName: String) {
        state = .loading
        webService.getRequestArray(url: WebRouter.getContributors(ownerName, repositoryName).url, responseType: ContributorModel.self) { [weak self] (result, error) in
            guard let self = self else { return }
            guard let contributorList = result else {
                self.state = .error
                self.errorMessage = error?.localizedDescription
                return
            }
            self.state = .filled
            self.generateContributorListCellVM(contributorList: contributorList)
        }
    }
    
    
    
    // Process Branch List
    func generateBranchListCellVM(branchList: [BranchModel]) {
        var branchListCellVM: [BranchesListCellViewModel] = []
        branchList.forEach { (branch) in
            branchListCellVM.append(BranchesListCellViewModel(branchName: branch.name))
        }
        self.branchListCellViewModel = branchListCellVM
    }
    
    // Process Fork List
    func generateForkListCellVM(forkList: [ForkModel]) {
        var forkListCellVM: [ForkListCellViewModel] = []
        forkList.forEach { (fork) in
            forkListCellVM.append(ForkListCellViewModel(avatarImage: fork.owner.avatarURL, ownerName: fork.owner.login))
        }
        self.forkListCellViewModel = forkListCellVM
    }
    
    // Process Contributor List
    func generateContributorListCellVM(contributorList: [ContributorModel]) {
        var contributorListCellVM: [ContributorListCellViewModel] = []
        contributorList.forEach { (contributor) in
            contributorListCellVM.append(ContributorListCellViewModel(avatarImage: contributor.avatarURL, ownerName: contributor.login))
        }
        self.contributorListCellViewModel = contributorListCellVM
    }
}
