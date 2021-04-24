//
//  RepoListVC+NavigationExtension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- Navigation
extension RepoListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let repositoryDetailsVC = segue.destination as? RepoDetailViewController,
            let repository = selectedRepository {
            repositoryDetailsVC.ownerAvatar = repository.ownerAvatar
            repositoryDetailsVC.repositoryName = repository.repositoryName
            repositoryDetailsVC.ownerName = repository.ownerName
            repositoryDetailsVC.createionDate = repository.creationDate
            repositoryDetailsVC.branches = viewModel.branchesURL
            repositoryDetailsVC.contributors = viewModel.contributorsURL
            repositoryDetailsVC.forks = viewModel.forksURL
        }
    }
}
