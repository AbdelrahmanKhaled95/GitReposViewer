//
//  RepoDetailsVC+GenericBranchListTableViewExtension.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import UIKit

//MARK:- Generic TableView closures
extension RepoDetailViewController {
    func configRepoTable(item: BranchesListCellViewModel, cell: UITableViewCell) {
        cell.textLabel?.text = item.branchName
    }
    func selectHelper(item: BranchesListCellViewModel, index: Int) {
    }
}
