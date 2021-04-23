//
//  RepoListVC+GenericTableViewExtension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- Generic TableView closures
extension RepoListViewController {
    func configRepoTable(item: RepoListCellViewModel, cell: RepositoryTableViewCell) {
        cell.repoListCellViewModel = item
    }
    func selectHelper(item: RepoListCellViewModel) {
        print(item.repositoryName)
    }
}
