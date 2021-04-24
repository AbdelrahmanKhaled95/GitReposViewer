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
                }
            }
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activitySpinner.stopAnimating()
                    UIView.animate(withDuration: 0.1, animations: {
                        
                        self.activitySpinner.isHidden = true
                    })
                case .loading:
                    self.activitySpinner.startAnimating()
                    UIView.animate(withDuration: 0.1, animations: {
                        
                        self.activitySpinner.isHidden = false
                    })
                case .filled:
                    self.activitySpinner.stopAnimating()
                    UIView.animate(withDuration: 0.1, animations: {
                        
                        self.activitySpinner.isHidden = true
                    })
                }
            }
        }
        viewModel.reloadTableView = { [weak self] () in
            guard let self = self else { return }
            guard let genericTableView = self.genericTableView else { return }
            DispatchQueue.main.async {
                genericTableView.reloadTable(data: self.viewModel.repoListCellViewModels)
            }
        }
        viewModel.initalFetchGitHubRepositories()
    }
}
