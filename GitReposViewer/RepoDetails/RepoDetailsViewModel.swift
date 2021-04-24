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
            self.genrateBranchListCellVM(branchList: branchList)
        }
    }
    
    // Process Branch List
    func genrateBranchListCellVM(branchList: [BranchModel]) {
        var branchListCellVM: [BranchesListCellViewModel] = []
        branchList.forEach { (branch) in
            branchListCellVM.append(BranchesListCellViewModel(branchName: branch.name))
        }
        self.branchListCellViewModel = branchListCellVM
    }
}
