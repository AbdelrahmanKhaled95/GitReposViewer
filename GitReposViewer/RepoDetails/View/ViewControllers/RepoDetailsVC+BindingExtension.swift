//
//  RepoDetailsVC+BindingExtension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- Setup binding
extension RepoDetailViewController {
    func setupBinding() {
        viewModel.showAlert = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let message = self.viewModel.errorMessage {
                    self.showAlert(message)
                    self.genericTableView?.setEmptyMessage(message)
                    self.forkGenericCollectionView?.setEmptyMessage(message)
                    self.contributorGenericCollectionView?.setEmptyMessage(message)
                }
            }
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch self.viewModel.state {
                case .empty, .error:
                    return
                case .loading:
                    return
                case .filled:
                    self.genericTableView?.restore()
                    self.forkGenericCollectionView?.restore()
                    self.forkGenericCollectionView?.restore()
                }
            }
        }
        viewModel.reloadTableView = { [weak self] () in
            guard let self = self else { return }
            guard let genericTableView = self.genericTableView else { return }
            DispatchQueue.main.async {
                genericTableView.reloadTable(data: self.viewModel.branchListCellViewModel)
            }
        }
        
        viewModel.reloadForkCollectionView = { [weak self] () in
            guard let self = self else { return }
            guard let forkGenericCollectionView = self.forkGenericCollectionView else { return }
            DispatchQueue.main.async {
                forkGenericCollectionView.reloadTable(data: self.viewModel.forkListCellViewModel)
            }
        }
        
        viewModel.reloadContributorCollectionView = { [weak self] () in
            guard let self = self else { return }
            guard let contributorGenericCollectionView = self.contributorGenericCollectionView else { return }
            DispatchQueue.main.async {
                contributorGenericCollectionView.reloadTable(data: self.viewModel.contributorListCellViewModel)
            }
        }
        guard let ownerName = ownerName, let repositoryName = repositoryName else { return }
        viewModel.fetchRepoBranches(ownerName: ownerName, repositoryName: repositoryName)
        viewModel.fetchRepoForks(ownerName: ownerName, repositoryName: repositoryName)
        viewModel.fetchRepoContributors(ownerName: ownerName, repositoryName: repositoryName)
    }
}
